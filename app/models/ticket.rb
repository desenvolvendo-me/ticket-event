# == Schema Information
#
# Table name: tickets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  student_id :bigint           not null
#
# Indexes
#
#  index_tickets_on_event_id    (event_id)
#  index_tickets_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (student_id => students.id)
#
class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :student

  has_one_attached :svg
  has_one_attached :png
end