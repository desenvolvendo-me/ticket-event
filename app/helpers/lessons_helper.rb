require 'uri'
require 'nokogiri'
require 'open-uri'

module LessonsHelper
  def get_iframe_url(video_url)
    uri = URI.parse(video_url)
    video_id = uri.path.split('/').last
    iframe_url = "https://www.youtube.com/embed/#{video_id}"
    Rails.logger.info "iframe_url: #{iframe_url}"
    iframe_url
  end

  def get_youtube_title(url)
    doc = Nokogiri::HTML(URI.open(url))
    title = doc.at_css('title').text
    return title.gsub(' - YouTube', '')
  end

end
