# == Schema Information
#
# Table name: winner_tickets
#
#  id            :bigint           not null, primary key
#  winner        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prize_draw_id :bigint           not null
#  ticket_id     :bigint           not null
#
# Indexes
#
#  index_winner_tickets_on_prize_draw_id  (prize_draw_id)
#  index_winner_tickets_on_ticket_id      (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (prize_draw_id => prize_draws.id)
#  fk_rails_...  (ticket_id => tickets.id)
#
class WinnerTicket < ApplicationRecord
  belongs_to :prize_draw, dependent: :destroy
  belongs_to :ticket
end
