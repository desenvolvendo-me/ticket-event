module Certificates
  class Builder < BusinessApplication
    def initialize(certificate:)
      @certificate = certificate
      @student = @certificate.student
      @event = @certificate.event
      @event_certificate_template = @event.certificate_template.download
    end

    def call
      modify_svg_content
      generate_svg
      generate_png_from_svg
      attach_svg_and_png
      remove_svg_and_png
    end

    private

    def modify_svg_content
      @copy_path = "tmp/certificate-#{@certificate.id}"
      @svg_path = @copy_path + ".svg"
      @svg_content = Nokogiri::XML(@event_certificate_template)

      replacements = {
        "NOME" => first_and_last_name(@student)
      }

      @svg_content.css("//text").each do |text_element|
        text_content = text_element.content
        new_content = text_content.dup
        replacements.each do |search_text, replacement|
          new_content.gsub!(search_text, replacement)
        end
        text_element.content = new_content
      end
    end

    def first_and_last_name(student)
      array = student.name.split
      "#{array.first} #{array.last}"
    end

    def generate_svg
      File.open(@svg_path, 'w') { |file| file.write(@svg_content.to_xml) }
    end

    def attach_svg_and_png
      @certificate.svg.attach(io: File.open(@svg_path), filename: "certificate-#{@certificate.id}.svg")
      @certificate.png.attach(io: File.open(@svg_path), filename: "certificate-#{@certificate.id}.png")
    end

    def remove_svg_and_png
      return unless Rails.env.development?

      FileUtils.rm_f(@png_path)
      FileUtils.rm_f(@svg_path)
    end

    def generate_png_from_svg
      @png_path = @copy_path + ".png"
      image = MiniMagick::Image.open(@svg_path)
      image.format 'png'
      image.write @png_path
    end
  end
end