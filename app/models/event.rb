
# == Schema Information
#
# Table name: events
#
#  id                                    :bigint           not null, primary key
#  active                                :boolean          default(TRUE)
#  community_link                        :string
#  date                                  :datetime
#  description                           :string
#  duration                              :integer
#  is_visible_after_time                 :boolean          default(FALSE)
#  is_visible_during_event               :boolean          default(FALSE)
#  is_visible_to_registered_participants :boolean          default(FALSE)
#  launch                                :integer
#  name                                  :string
#  purchase_date                         :datetime
#  purchase_link                         :string
#  slug                                  :string
#  visible_after_time                    :time
#  visible_during_event_end              :datetime
#  visible_during_event_start            :datetime
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
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
  has_one :prize_draw, dependent: :destroy
  accepts_nested_attributes_for :prize_draw

  validates :name, :launch, presence: true
  validate :valid_duration_format

  has_one_attached :template
  has_one_attached :certificate_template
  has_one_attached :image

  before_save :validate_visibility_fields

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

  private

  def validate_visibility_fields
    if is_visible_after_time? && visible_after_time.blank?
      errors.add(:visible_after_time, "can't be blank when 'Visible After Time' is selected")
    end
    errors.empty?
  end
end
