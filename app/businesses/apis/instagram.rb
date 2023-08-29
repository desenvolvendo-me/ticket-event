require "open-uri" # Allows us to send GET requests and receive the response
require "json" # A
module Apis
  class Instagram < BusinessApplication

    def initialize(student: nil)
      @student = student
    end

    def call
      response = open("https://www.instagram.com/#{@student.profile_social.delete("@")}/?__a=1&__d=1").read
      json = JSON.parse(response)
      json["graphql"]["user"]["profile_pic_url_hd"]
    end
  end
end
