# == Schema Information
#
# Table name: students
#
#  id             :bigint           not null, primary key
#  email          :string
#  name           :string
#  phone          :string
#  profile_social :string
#  type_social    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Student < ApplicationRecord
  has_many :tickets
  has_many :certificates, dependent: :destroy
  has_many :prize_draws, dependent: :destroy

  has_one_attached :avatar

  TYPE_SOCIAL = %w[github aleatória]

end
