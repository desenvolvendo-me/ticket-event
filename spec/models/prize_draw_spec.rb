# == Schema Information
#
# Table name: prize_draws
#
#  id         :bigint           not null, primary key
#  date       :datetime
#  name       :string
#  prize      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  ticket_id  :bigint
#
# Indexes
#
#  index_prize_draws_on_ticket_id  (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (ticket_id => tickets.id)
#
require 'rails_helper'

RSpec.describe PrizeDraw, type: :model do
  it { should belong_to(:event)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:date)}
  it { should validate_presence_of(:prize)}
  it { should have_one(:winner_ticket).dependent(:destroy) }
  it { should have_many(:ticket)}
end
