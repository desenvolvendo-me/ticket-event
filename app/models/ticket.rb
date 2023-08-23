# == Schema Information
#
# Table name: tickets
#
#  id            :bigint           not null, primary key
#  number        :string
#  send_email_at :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  event_id      :bigint           not null
#  student_id    :bigint           not null
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

  scope :not_send_email, -> { where(send_email_at: nil) }

  before_create :before_create

  private

  def before_create
    Tickets::Number.call(ticket: self)
  end
end
