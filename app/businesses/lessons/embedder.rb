module Lessons
  class Embedder
    def self.embed_url(video_url)
      uri = URI.parse(video_url)
      video_id = extract_video_id(uri)
      iframe_url = "https://www.youtube.com/embed/#{video_id}"
      iframe_url
    end

    private

    def self.extract_video_id(uri)
      if uri.path.include?('/v/')
        return uri.path.split('/v/').last
      elsif uri.host == 'youtu.be'
        return uri.path.split('/').last
      elsif uri.path.include?('/live/')
        return uri.path.split('/live/').last.split('?').first
      elsif uri.query && uri.query.include?('v=')
        params = URI.decode_www_form(uri.query)
        video_id = params.assoc('v').last
        return video_id
      else
        raise ArgumentError, I18n.t('businesses.lesson.embedder.extract_video_error')
      end
    end
  end
end
