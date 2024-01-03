
# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  community_link :string
#  date           :datetime
#  description    :string
#  duration       :integer
#  launch         :integer
#  name           :string
#  purchase_date  :datetime
#  purchase_link  :string
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_events_on_slug  (slug) UNIQUE
#
class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :launch_and_name, use: :slugged

  has_many :tickets, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :name, :launch, :duration, presence: true
  validate :valid_duration_format

  has_one_attached :template
  has_one_attached :certificate_template
  has_one_attached :image

  def valid_duration_format
    errors.add(:duration, :invalid) unless duration.is_a?(Integer) && duration.positive?
  end

  def image_large
    return unless image.content_type.in?(%w[image/jpeg image/png])
    image.variant(resize_to_limit: [1600,900]).processed
  end
  def image_medium
    return unless image.content_type.in?(%w[image/jpeg image/png])
    image.variant(resize_to_limit: [940,348]).processed
  end
  def image_small
    return unless image.content_type.in?(%w[image/jpeg image/png])
    image.variant(resize_to_limit: [600,600]).processed
  end

  scope :active, -> { where(active: true) }

  def launch_and_name
    "#{launch}-#{name}"
  end
end
