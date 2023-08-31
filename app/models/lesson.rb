# == Schema Information
#
# Table name: lessons
#
#  id         :bigint           not null, primary key
#  link       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_lessons_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
class Lesson < ApplicationRecord
  belongs_to :event
  validates :link, presence: true

  validate :max_lessons_per_event

  private

  def max_lessons_per_event
    if event.lessons.count >= 5
      errors.add(:event, I18n.t("lesson.max_lessons") + "#{event.name}")
    end
  end
end
