require 'nokogiri'
require 'csv'
require 'mini_magick'

module Tickets
  class Builder < BusinessApplication
    def initialize(event:, csv_path:)
      @event = event
      @csv_path = csv_path
      @event_template = @event.template.download
    end

    def call
      CSV.foreach(@csv_path, headers: true) do |row|
        create_student(row)
        create_ticket
        modify_svg_content
        add_photo_to_svg
        generate_svg
        generate_png_from_svg
        attach_svg_and_png_to_ticket
        remove_svg_and_png
      end
    end

    private

    def create_student(row)
      @student = Student.create(
        name: row["fullname"],
        email: row["email"],
        phone: row["phone"]
      )
    end

    def create_ticket
      @ticket = Ticket.create(student: @student, event: @event)
    end

    def modify_svg_content
      @copy_path = "tmp/ticket-#{@ticket.id}"
      @svg_path = @copy_path + ".svg"
      @svg_content = Nokogiri::XML(@event_template)

      replacements = {
        "NOME" => first_and_last_name(@student),
        "DATA_EVENTO" => create_date_event,
        "NUMERO" => @ticket.number.to_s
      }

      @svg_content.css("//text").each do |text_element|
        text_content = text_element.content
        new_content = text_content.dup
        replacements.each { |search_text, replacement| new_content.gsub!(search_text, replacement) }
        text_element.content = new_content
      end

    end

    def add_photo_to_svg
      text_node = @svg_content.at_xpath("//*[text()='FOTO']")

      if text_node
        x_position = (text_node['x'].to_i - 100).to_s || "0"
        y_position = (text_node['y'].to_i / 2).to_s || "0"

        text_node.remove

        img = Nokogiri::XML::Node.new "image", @svg_content
        img['xlink:href'] = round_image_corners("spec/support/avatar.png")
        img['x'] = x_position
        img['y'] = y_position
        img['width'] = "350"
        img['height'] = "350"

        @svg_content.root.add_child(img)
      end
    end

    def generate_svg
      File.open(@svg_path, 'w') { |file| file.write(@svg_content.to_xml) }
    end

    def generate_png_from_svg
      @png_path = @copy_path + ".png"
      image = MiniMagick::Image.open(@svg_path)
      image.format 'png'
      image.write @png_path
    end

    def attach_svg_and_png_to_ticket
      @ticket.svg.attach(io: File.open(@svg_path), filename: "ticket-#{@ticket.id}.svg")
      @ticket.png.attach(io: File.open(@png_path), filename: "ticket-#{@ticket.id}.png")
    end

    def first_and_last_name(student)
      array = student.name.split
      "#{array.first} #{array.last}"
    end

    def round_image_corners(input_path, radius = 30)
      image = MiniMagick::Image.open(input_path)
      image.alpha("set")

      clone = image.clone
      clone.combine_options do |c|
        c.distort("DePolar", "0")
        c.virtual_pixel("HorizontalTile")
        c.background("None")
        c.distort("Polar", "0")
      end

      image = image.composite(clone) do |c|
        c.compose("Dst_In")
      end

      image.trim
      image.repage("+0+0")

      @png_round_path = "tmp/image-ticket-#{@ticket.id}.png"

      image.write @png_round_path

      @png_round_path
    end

    def create_date_event
      @event.date.strftime("%d/%m | %H:%Mh")
    end

    def remove_svg_and_png
      FileUtils.rm_f(@svg_path)
      FileUtils.rm_f(@png_path)
      FileUtils.rm_f(@png_round_path)
    end
  end
end
