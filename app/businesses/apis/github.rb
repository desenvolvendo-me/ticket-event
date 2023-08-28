require "open-uri" # Allows us to send GET requests and receive the response
require "json" # A
module Apis
  class Github < BusinessApplication

    def initialize(student: nil)
      @student = student
    end

    def call
      results = HTTParty.get("https://api.github.com/users/#{@student.profile_social.delete("@")}", :headers => {
        "Accept" => "application/vnd.github+json",
        "X-GitHub-Api-Version" => "2022-11-28",
        "Authorization" => "Bearer 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"
      })
      results["avatar_url"]
    rescue
      nil
    end
  end
end
