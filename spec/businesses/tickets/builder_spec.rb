require 'rails_helper'

RSpec.describe Tickets::Builder do
  let(:event) { create(:event) }
  let(:csv_path) { 'spec/support/leads_export.csv' }
  let(:builder) { Tickets::Builder.new(event: event, csv_path: csv_path) }

  it 'builds tickets with SVG and PNG attachments' do
    builder.call

    first_ticket = event.tickets.first
    last_ticket = event.tickets.last

    expect(first_ticket.svg.filename.to_s).to eq("ticket-1.svg")
    expect(first_ticket.png.filename.to_s).to eq("ticket-1.png")
    expect(last_ticket.svg.filename.to_s).to eq("ticket-2.svg")
    expect(last_ticket.png.filename.to_s).to eq("ticket-2.png")
  end
end
