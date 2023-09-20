# == Schema Information
#
# Table name: raffles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  winner_id  :bigint           not null
#
# Indexes
#
#  index_raffles_on_event_id   (event_id)
#  index_raffles_on_winner_id  (winner_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (winner_id => students.id)
#
class Raffle < ApplicationRecord
  belongs_to :event
  belongs_to :winner, class_name: "Student"
end
