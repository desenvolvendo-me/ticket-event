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
class Student < ApplicationRecord
  has_many :tickets
  has_many :certificates, dependent: :destroy
  belongs_to :student_user

  has_one_attached :avatar

  TYPE_SOCIAL = %w[github aleatória]

end
