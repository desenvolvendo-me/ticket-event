require 'twilio-ruby'

module Notifiers
  class Whatsapp < BusinessApplication
    def initialize(ticket: nil)
      @ticket = ticket
      @account_sid = 'ACfce8274f29cb54bdc1c426e1d547eaf5'
      @auth_token = '7e13d6a4994cfee3b4f6007b4bde14a4'
    end

    def call
      @client = Twilio::REST::Client.new(@account_sid, @auth_token)
      boby = "#{@ticket.student.name} chegou seu ingresso! https://www.twilio.com/docs/whatsapp"

      @client.messages.create(
        from: 'whatsapp:+14155238886',
        body: boby,
        to: 'whatsapp:+554892040945'
      )
    end
  end
end
