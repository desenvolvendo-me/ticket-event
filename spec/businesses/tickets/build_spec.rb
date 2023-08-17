require 'rails_helper'

RSpec.describe Tickets::Build do

  it 'build' do
    ticket_changed = "spec/support/ticket-changed.svg"
    ticket_success = "spec/support/ticket-success.svg"

    Tickets::Build.call({ template_path: "spec/support/ticket.svg" })

    expect(File.read(ticket_changed)).to eq(File.read(ticket_success))
  end

end