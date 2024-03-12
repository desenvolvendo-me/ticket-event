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
require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should have_many(:lessons)}
  it { should have_many(:certificates)}
  it { should have_many(:tickets)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:launch)}
  it { should have_one_attached(:template)}
  it { should have_one_attached(:certificate_template)}
  it { should have_one_attached(:image)}

  describe "visibility fields" do
    let(:event) { create(:event) } # Assuming you have a factory for Event model

    it "should fill corresponding fields when is_visible_to_registered_participants is true" do
      event.update(is_visible_to_registered_participants: true)
      expect(event.is_visible_to_registered_participants).to eq(true)
      expect(event.is_visible_after_time).to eq(false)
      expect(event.visible_after_time).to be_nil
      expect(event.is_visible_during_event).to eq(false)
    end

    it "should fill corresponding fields when is_visible_after_time is true" do
      event.update(is_visible_after_time: true, visible_after_time: Time.now)
      expect(event.is_visible_to_registered_participants).to eq(false)
      expect(event.is_visible_after_time).to eq(true)
      expect(event.visible_after_time).not_to be_nil
      expect(event.is_visible_during_event).to eq(false)
    end

    it "should fill corresponding fields when is_visible_during_event is true" do
      event.update(is_visible_during_event: true, visible_during_event_start: Time.now, visible_during_event_end: Time.now + 1.hour)
      expect(event.is_visible_to_registered_participants).to eq(false)
      expect(event.is_visible_after_time).to eq(false)
      expect(event.visible_after_time).to be_nil
      expect(event.is_visible_during_event).to eq(true)
    end
  end
end
