# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :student do
    name { "Vitor Utagawa Tanabe" }
    email { "marcodotcastro@gmail.com" }
    phone { "61991707479" }
  end
end
