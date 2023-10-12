require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { should belong_to(:event) }
  it { should validate_presence_of(:link) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_one(:quiz).dependent(:destroy) }
  it { should have_one_attached(:thumbnail) }
end
