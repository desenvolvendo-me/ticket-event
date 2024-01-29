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
      setup_svg_content

      replacements = {
        "NOME" => first_and_last_name(@student),
        "DT_INI" => event_start_date,
        "DT_FIM" => event_end_date,
        "DT_EMI" => issuance_date,
        "VERIFICATION_LINK" => @certificate.verification_link
      }

      replace_text_in_svg_content(replacements)
    end

    def setup_svg_content
      @copy_path = "tmp/certificate-#{@certificate.id}"
      @svg_path = @copy_path + ".svg"
      @svg_content = Nokogiri::XML(@event_certificate_template)
    end

    def first_and_last_name(student)
      array = student.name.split
      "#{array.first} #{array.last}"
    end

    def event_start_date
      I18n.l(@event.date.to_date, format: :default)
    end

    def event_end_date
      I18n.l((@event.date + 6.days).to_date, format: :default)
    end

    def issuance_date
      I18n.l(@certificate.created_at.to_date, format: :default)
    end

    def replace_text_in_svg_content(replacements)
      @svg_content.css("//text").each do |text_element|
        text_element.content = gsub_text_nodes(text_element.content, replacements)
      end
    end

    def gsub_text_nodes(text, replacements)
      replacements.each do |search_text, replacement|
        text.gsub!(search_text, replacement)
      end
      text
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

    def attach_svg_and_png
      @certificate.svg.attach(io: File.open(@svg_path), filename: "certificate-#{@certificate.id}.svg")
      @certificate.png.attach(io: File.open(@png_path), filename: "certificate-#{@certificate.id}.png")
    end

    def remove_svg_and_png
      return unless Rails.env.development?

      FileUtils.rm_f(@png_path)
      FileUtils.rm_f(@svg_path)
    end
  end
end
