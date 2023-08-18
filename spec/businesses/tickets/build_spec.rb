require 'rails_helper'

RSpec.describe Tickets::Build do

  it 'build' do
    event = create(:event)
    csv_path = 'spec/support/leads_export.csv'

    Tickets::Build.call({ event: event, csv_path: csv_path })

    expect(event.tickets.first.svg.filename.to_s).to eq("ticket-1.svg")
    expect(event.tickets.first.png.filename.to_s).to eq("ticket-1.png")
    expect(event.tickets.last.svg.filename.to_s).to eq("ticket-2.svg")
    expect(event.tickets.last.png.filename.to_s).to eq("ticket-2.png")
  end

end