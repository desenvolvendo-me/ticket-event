# == Schema Information
#
# Table name: prize_draws
#
#  id         :bigint           not null, primary key
#  date       :datetime
#  name       :string
#  prize      :string
#  winner     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#
FactoryBot.define do
  factory :prize_draw do
    name { 'Bootcamp' }
    date { DateTime.now }
    prize { 'Mouse' }
    association :event, factory: :event
  end
end
