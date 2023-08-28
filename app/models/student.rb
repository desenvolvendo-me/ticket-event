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
class Student < ApplicationRecord
  has_many :tickets

  TYPE_SOCIAL = %w[instagram github]

end
