# == Schema Information
#
# Table name: prize_draws
#
#  id            :bigint           not null, primary key
#  date          :datetime
#  name          :string
#  prize         :string
#  winner_ticket :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  event_id      :bigint           not null
#
class PrizeDraw < ApplicationRecord
  belongs_to :event
  has_many :tickets

  validates :name, :date, :prize, presence: :true
end
