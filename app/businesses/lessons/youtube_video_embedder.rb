module Lessons
  class YoutubeVideoEmbedder
    def self.embed_url(video_url)
      uri = URI.parse(video_url)
      video_id = uri.path.split('/').last
      iframe_url = "https://www.youtube.com/embed/#{video_id}"
      iframe_url
    end
  end
end

