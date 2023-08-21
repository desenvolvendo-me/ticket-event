require 'rails_helper'

RSpec.describe Notifiers::Whatsapp do
  let(:ticket) { create(:ticket) }

  it 'call' do
    Notifiers::Whatsapp.call(ticket: ticket)
  end
end
