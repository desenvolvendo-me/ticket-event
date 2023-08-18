require 'nokogiri'
require 'csv'
require 'mini_magick'

module Tickets
  class Build < BusinessApplication

    def initialize(**params)
      @params = params
      @event = @params[:event]
    end

    def call
      svg_file_path = @event.template.download

      CSV.foreach(@params[:csv_path], headers: true) do |row|
        student = Student.create(name: row[:name], email: row[:email], phone: row[:phone])

        ticket = Ticket.create(student: student, event: @event)

        svg_content = Nokogiri::XML(svg_file_path)

        replacements = {
          "NOME" => first_and_last_name(row)
        }

        svg_copy_path = "tmp/ticket-#{ticket.id}"

        svg_content.css("//text").each do |text_element|
          text_content = text_element.content
          new_content = text_content.dup
          replacements.each { |search_text, replacement| new_content.gsub!(search_text, replacement) }
          text_element.content = new_content
        end

        File.open(svg_copy_path + ".svg", 'w') { |file| file.write(svg_content.to_xml) }

        image = MiniMagick::Image.open(svg_copy_path + ".svg")

        image.format 'png'
        image.write svg_copy_path + ".png"

        ticket.svg.attach(io: File.open(svg_copy_path + ".svg"), filename: "ticket-#{ticket.id}.svg")
        ticket.png.attach(io: File.open(svg_copy_path + ".png"), filename: "ticket-#{ticket.id}.png")

        FileUtils.rm_f(svg_copy_path + ".svg")
        FileUtils.rm_f(svg_copy_path + ".png")
      end

    end

    private

    def first_and_last_name(row)
      array = row['fullname'].split
      array.first + " " + array.last
    end

  end
end