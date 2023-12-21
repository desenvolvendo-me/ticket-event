# == Schema Information
#
# Table name: prize_draws
#
#  id            :bigint           not null, primary key
#  date          :datetime
#  name          :string
#  prize         :string
#  prize_draw    :string
#  winner_ticket :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  event_id      :integer          not null
#  ticket_id     :bigint           not null
#
# Indexes
#
#  index_prize_draws_on_event_id   (event_id)
#  index_prize_draws_on_ticket_id  (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (ticket_id => tickets.id)
#
class PrizeDraw < ApplicationRecord
  belongs_to :ticket
  belongs_to :event

end
