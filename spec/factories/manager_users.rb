# == Schema Information
#
# Table name: manager_users
#
#  id                     :bigint           not null, primary key
#  avatar                 :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string
#  login                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_manager_users_on_email                 (email) UNIQUE
#  index_manager_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :manager_user do
    sequence(:email) { |n| "infoprodutor#{n}@gmail.com" }
    password { "123456abc" }
  end
end
