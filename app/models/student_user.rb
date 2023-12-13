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
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    student_user = StudentUser.where(email: data['email']).first

    unless student_user
        student_user = StudentUser.create(
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    student_user
  end
end
