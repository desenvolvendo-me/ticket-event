require 'rails_helper'

RSpec.describe Lessons::Embedder, type: :lib do
  describe '.embed_url' do
    it 'returns the embedded YouTube video URL' do
      video_url = 'https://www.youtube.com/watch?v=3qgcPXnmbA8&ab_channel=JacksonPires'
      embedded_url = Lessons::Embedder.embed_url(video_url)
      expected_url = 'https://www.youtube.com/embed/3qgcPXnmbA8'

      expect(embedded_url).to eq(expected_url)
    end

    it 'handles different YouTube video URL formats' do
      video_url1 = 'https://www.youtube.com/watch?v=dWVo2Ma6ZpU&t=5s&ab_channel=ProgramadorShowzim'
      video_url2 = 'https://youtube.com/v/dWVo2Ma6ZpU&t=5s'

      embedded_url1 = Lessons::Embedder.embed_url(video_url1)
      embedded_url2 = Lessons::Embedder.embed_url(video_url2)

      expected_url1 = 'https://www.youtube.com/embed/dWVo2Ma6ZpU'
      expected_url2 = 'https://www.youtube.com/embed/dWVo2Ma6ZpU&t=5s'

      expect(embedded_url1).to eq(expected_url1)
      expect(embedded_url2).to eq(expected_url2)
    end
  end
end
