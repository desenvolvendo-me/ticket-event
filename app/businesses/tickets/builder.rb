require 'nokogiri'
require 'csv'
require 'mini_magick'

module Tickets
  class Builder < BusinessApplication
    def initialize(ticket:)
      @ticket = ticket
      @event = @ticket.event
      @event_template = @event.template.download
    end

    def call
      create_student
      modify_svg_content
      add_photo_to_svg
      generate_svg
      generate_png_from_svg
      attach_svg_and_png_to_ticket
      remove_svg_and_png
    end

    private

    def create_student
      @student = @ticket.student
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

        ticket_avatar_path = get_avatar

        img = Nokogiri::XML::Node.new "image", @svg_content
        img['xlink:href'] = round_image_corners(ticket_avatar_path)
        img['x'] = x_position
        img['y'] = y_position
        img['width'] = "350"
        img['height'] = "350"

        @svg_content.root.add_child(img)
      end
    end

    def get_avatar
      avatar = Apis::Instagram.call(student: @ticket.student)

      if avatar
        image = MiniMagick::Image.open(avatar)
      else
        image = MiniMagick::Image.open(Faker::LoremFlickr.image(size: "200x200", search_terms: ['animes']))
      end

      ticket_avatar_path = "tmp/ticket-avatar-#{@ticket.id}.png"
      image.write(ticket_avatar_path)
      ticket_avatar_path
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
      return unless Rails.env.development?

      FileUtils.rm_f(@png_path)
      FileUtils.rm_f(@svg_path)
      FileUtils.rm_f(@png_round_path)
    end
  end
end
