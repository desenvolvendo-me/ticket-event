FactoryBot.define do
  factory :prize_draw do
    name { 'Bootcamp' }
    date { DateTime.now }
    prize { 'Mouse' }
    association :event, factory: :event
  end
end
