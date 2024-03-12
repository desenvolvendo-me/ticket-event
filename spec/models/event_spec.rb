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
require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should have_many(:lessons)}
  it { should have_many(:certificates)}
  it { should have_many(:tickets)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:duration)}
  it { should validate_presence_of(:launch)}
  it { should have_one_attached(:template)}
  it { should have_one_attached(:certificate_template)}
  it { should have_one_attached(:image)}
end
