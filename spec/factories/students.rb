# == Schema Information
#
# Table name: students
#
#  id                 :bigint           not null, primary key
#  email              :string
#  name               :string
#  phone              :string
#  username_instagram :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
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
