require 'rails_helper'

RSpec.describe Tickets::Builder do
  let(:event) { create(:event) }
  let(:csv_path) { 'spec/support/leads_export.csv' }
  let(:builder) { Tickets::Builders.new(event: event, csv_path: csv_path) }

  it 'change image ticket' do
    builder.call

    first_ticket = event.tickets.first
    first_ticket.student.update(profile_social: "@marcodotcastro")

    Tickets::Builder.call(ticket: first_ticket)

    expect(first_ticket.svg.filename.to_s).to eq("ticket-1.svg")
    expect(first_ticket.png.filename.to_s).to eq("ticket-1.png")
  end
end
