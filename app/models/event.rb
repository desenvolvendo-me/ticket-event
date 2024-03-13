
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

  has_one_attached :template
  has_one_attached :certificate_template
  has_one_attached :image

  before_save :validate_event

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

  def visible_during_event?
    Events::HappeningNow.new(self).call
  end

  def visible_after_time?
    unless is_visible_after_time
      true
    else
      Time.now >= visible_after_time
    end
  end

  def visible_now?
    is_visible_during_event? || visible_after_time?
  end

  private

  def validate_event
    errors = Events::Validator.new(self).call

    add_errors(errors) unless errors.blank?
  end

  def add_errors(errors)
    errors.each { |error| self.errors.add(error.keys.first, error.values.first) }
    throw(:abort)
  end
end
