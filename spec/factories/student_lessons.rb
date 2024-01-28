# == Schema Information
#
# Table name: student_lessons
#
#  id         :bigint           not null, primary key
#  status     :string           default("not started")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lesson_id  :bigint
#  student_id :bigint
#
# Indexes
#
#  index_student_lessons_on_lesson_id   (lesson_id)
#  index_student_lessons_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (lesson_id => lessons.id)
#  fk_rails_...  (student_id => students.id)
#
FactoryBot.define do
  factory :student_lesson do
    student { nil }
    lesson { nil }
  end
end
