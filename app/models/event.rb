# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  community_link :string
#  date           :datetime
#  description    :string
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

  validates :name, :launch, presence: true

  has_one_attached :template
  has_one_attached :certificate_template
  has_one_attached :image

  def image_as_config
    return unless image.content_type.in?[%w(image/jpeg image/png)]
    image.variant(resize_to_limit: [600,300].processed)
  end

  scope :active, -> { where(active: true) }

  def launch_and_name
    "#{launch}-#{name}"
  end
end
