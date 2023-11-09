# == Schema Information
#
# Table name: manager_users
#
#  id                     :bigint           not null, primary key
#  avatar_url             :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string
#  login                  :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_manager_users_on_email                 (email) UNIQUE
#  index_manager_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class ManagerUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |manager_user|
      manager_user.email = auth.info.email
      manager_user.password = Devise.friendly_token[0, 20]
      manager_user.full_name = auth.info.name
      manager_user.avatar_url = auth.info.image
    end
  end
end
