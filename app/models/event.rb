# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  description :string
#  info        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Event < ApplicationRecord
  has_many :tickets

  has_one_attached :template
end
