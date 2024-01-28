# == Schema Information
#
# Table name: student_users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  student_id             :bigint
#
# Indexes
#
#  index_student_users_on_email                 (email) UNIQUE
#  index_student_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_student_users_on_student_id            (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#
class StudentUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
<<<<<<< HEAD
  has_one :student
=======

  has_one :student
  accepts_nested_attributes_for :student
>>>>>>> parent of 92e3119 (chore(revert): start a new devlopment about to commit from 5/01/24)
end
