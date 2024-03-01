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
#
# Indexes
#
#  index_student_users_on_email                 (email) UNIQUE
#  index_student_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class StudentUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :student, dependent: :destroy

  after_create :create_associated_student_if_not_exists

  private

  def create_associated_student_if_not_exists
    unless Student.exists?(email: email)
      Student.create(email: email, student_user_id: id)
    end
  end
end
