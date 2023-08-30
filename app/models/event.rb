# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  date        :datetime
#  description :string
#  launch      :integer
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_events_on_slug  (slug) UNIQUE
#
class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :launch_and_name, use: :slugged

  has_many :tickets, dependent: :destroy
  has_many :lessons

  validates :name, :launch, presence: true

  has_one_attached :template

  def launch_and_name
    "#{launch}-#{name}"
  end
end
