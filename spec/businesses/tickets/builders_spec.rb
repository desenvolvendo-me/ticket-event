require 'rails_helper'

RSpec.describe Tickets::Builders do
  let(:event) { create(:event) }
  let(:csv_path) { 'spec/support/leads_export.csv' }
  let(:builder) { Tickets::Builders.new(event: event, csv_path: csv_path) }

  it 'builds tickets with SVG and PNG attachments' do
    builder.call

    first_ticket = event.tickets.first
    last_ticket = event.tickets.last

    expect(first_ticket.svg.filename.to_s).to include "svg"
    expect(first_ticket.png.filename.to_s).to include "png"
    expect(last_ticket.svg.filename.to_s).to include "svg"
    expect(last_ticket.png.filename.to_s).to include "png"
  end
end
