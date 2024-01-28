# == Schema Information
#
# Table name: student_event_lesson_statuses
#
#  id          :bigint           not null, primary key
#  is_finished :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :bigint           not null
#  lesson_id   :bigint           not null
#  student_id  :bigint           not null
#
# Indexes
#
#  index_student_event_lesson_statuses_on_event_id    (event_id)
#  index_student_event_lesson_statuses_on_lesson_id   (lesson_id)
#  index_student_event_lesson_statuses_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (lesson_id => lessons.id)
#  fk_rails_...  (student_id => students.id)
#
class StudentEventLessonStatus < ApplicationRecord
  belongs_to :event
  belongs_to :student
  belongs_to :lesson
end
