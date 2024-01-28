# == Schema Information
#
# Table name: students
#
#  id              :bigint           not null, primary key
#  email           :string
#  name            :string
#  phone           :string
#  profile_social  :string
#  type_social     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  student_user_id :bigint
#
# Indexes
#
#  index_students_on_student_user_id  (student_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_user_id => student_users.id)
#
FactoryBot.define do
  factory :student do
    name { "Marco Castro" }
    email { "marco.castro@email.com" }
    phone { "61988887777" }
    type_social { "github"}
    profile_social { "@marcodotcastro"}
  end
end
