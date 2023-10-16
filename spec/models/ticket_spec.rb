require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should belong_to(:event)}
  it { should belong_to(:student)}
  it { should have_one(:prize_draw)}
  it { should have_one_attached(:svg)}
  it { should have_one_attached(:png)}
end