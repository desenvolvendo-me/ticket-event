require 'nokogiri'

module Tickets
  class Build < BusinessApplication

    def initialize(**params)
      @params = params
      @student = @params[:resource]
    end

    def call
      svg_file_path = @params[:template_path]
      svg_copy_path = 'spec/support/ticket-changed.svg'

      svg_content = File.open(svg_file_path) { |f| Nokogiri::XML(f) }

      replacements = {
        "NOME" => "MARCO CASTRO",
        "EMAIL" => "marcodotcastro@gmail.com"
      }

      svg_content.css("//text").each do |text_element|
        text_content = text_element.content
        new_content = text_content.dup
        replacements.each { |search_text, replacement| new_content.gsub!(search_text, replacement) }
        text_element.content = new_content
      end

      File.open(svg_copy_path, 'w') { |file| file.write(svg_content.to_xml) }
    end

  end
end