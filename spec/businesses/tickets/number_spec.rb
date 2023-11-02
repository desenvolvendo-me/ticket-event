require 'rails_helper'

RSpec.describe Tickets::Number do

  it 'create uniq number' do
    ticket = create(:ticket)

    expect(ticket.number.to_i).to be_a(Integer).and satisfy { |num| num >= 1 && num <= 99_999 }
  end
end
