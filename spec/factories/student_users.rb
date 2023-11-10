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
FactoryBot.define do
  factory :student_user do
    sequence(:email) { |n| "student#{n}@gmail.com" }
    password { "123456abc" }
  end
end