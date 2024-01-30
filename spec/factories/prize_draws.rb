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
#  index_prize_draws_on_event_id   (event_id)
#  index_prize_draws_on_ticket_id  (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (ticket_id => tickets.id)
#
FactoryBot.define do
  factory :prize_draw do
    name { 'Bootcamp' }
    date { DateTime.now }
    prize { 'Mouse' }
    association :event, factory: :event
  end
end
