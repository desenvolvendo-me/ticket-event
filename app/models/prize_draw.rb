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
#  event_id      :integer          not null
#  ticket_id     :bigint           not null
#
# Indexes
#
#  index_prize_draws_on_ticket_id  (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (ticket_id => tickets.id)
#
class PrizeDraw < ApplicationRecord
  has_one :ticket, dependent: :destroy
  belongs_to :event
  accepts_nested_attributes_for :ticket

  validates :name, :date, :prize, presence: :true
end
