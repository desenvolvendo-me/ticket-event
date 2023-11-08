# == Schema Information
#
# Table name: lessons
#
#  id              :bigint           not null, primary key
#  description     :text
#  launch_datetime :datetime
#  link            :string
#  thumbnail       :string
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  event_id        :bigint           not null
#  manager_user_id :integer
#
# Indexes
#
#  index_lessons_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { should belong_to(:event) }
  it { should validate_presence_of(:link) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_one(:quiz).dependent(:destroy) }
  it { should have_one_attached(:thumbnail) }
end
