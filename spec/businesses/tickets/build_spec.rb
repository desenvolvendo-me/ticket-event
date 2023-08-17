require 'rails_helper'

RSpec.describe Tickets::Build do

  it 'build' do
    csv_path = 'spec/support/leads_export.csv'
    template_path = "spec/support/ticket.svg"

    Tickets::Build.call({ template_path: template_path, csv_path: csv_path })

    expect(File.exist?("spec/support/ticket-changed-61991707479.svg")).to be(true)
    expect(File.exist?("spec/support/ticket-changed-61991707479.png")).to be(true)
    expect(File.exist?("spec/support/ticket-changed-5561991707479.svg")).to be(true)
    expect(File.exist?("spec/support/ticket-changed-5561991707479.png")).to be(true)
  end

end