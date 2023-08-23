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
      svg_content = Nokogiri::XML(@event_template)

      replacements = {
        "NOME" => first_and_last_name(@student),
        "DATA_EVENTO" => create_date_event,
        "PP" => @event.tickets.count.to_s,
        # "CD" => ticket.id.to_s, # TODO: Adicionar o número único por evento
      }

      svg_content.css("//text").each do |text_element|
        text_content = text_element.content
        new_content = text_content.dup
        replacements.each { |search_text, replacement| new_content.gsub!(search_text, replacement) }
        text_element.content = new_content
      end

      File.open(@svg_path, 'w') { |file| file.write(svg_content.to_xml) }
    end

    def create_date_event
      @event.date.strftime("%d/%m | %H:%Mh")
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

    def remove_svg_and_png
      FileUtils.rm_f(@svg_path)
      FileUtils.rm_f(@png_path)
    end
  end
end
