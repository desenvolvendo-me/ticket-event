# == Schema Information
#
# Table name: lessons
#
#  id         :bigint           not null, primary key
#  link       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
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
end
