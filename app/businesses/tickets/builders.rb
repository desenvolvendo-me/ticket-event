require 'nokogiri'
require 'csv'
require 'mini_magick'

module Tickets
  class Builders < BusinessApplication
    def initialize(event:, csv_path:)
      @event = event
      @csv_path = csv_path
      @event_template = @event.template.download
    end

    def call
      CSV.foreach(@csv_path, headers: true) do |row|
        @student = Students::Creator.call(row)
        create_ticket
        Tickets::Builder.call(ticket: @ticket)
      end
    end

    private

    def create_ticket
      @ticket = Ticket.create(student: @student, event: @event)
    end
  end
end
