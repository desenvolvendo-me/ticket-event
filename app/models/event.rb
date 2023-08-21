# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  description :string
#  info        :string
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
  friendly_id :name, use: :slugged

  has_many :tickets

  has_one_attached :template
end
