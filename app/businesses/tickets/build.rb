require 'nokogiri'
require 'csv'
require 'mini_magick'

module Tickets
  class Build < BusinessApplication

    def initialize(**params)
      @params = params
      @student = @params[:resource]
    end

    def call
      svg_file_path = @params[:template_path]

      CSV.foreach(@params[:csv_path], headers: true) do |row|
        svg_content = File.open(svg_file_path) { |f| Nokogiri::XML(f) }

        replacements = {
          "NOME" => first_and_last_name(row)
        }

        svg_copy_path = "spec/support/ticket-changed-#{row['phone'] }"

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
      end

    end

    private

    def first_and_last_name(row)
      array = row['fullname'].split
      array.first + " " + array.last
    end

  end
end