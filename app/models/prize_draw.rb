# == Schema Information
#
# Table name: prize_draws
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ticket_id  :bigint           not null
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
  belongs_to :ticket
end
