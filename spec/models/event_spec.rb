require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should have_many(:lessons)}
  it { should have_many(:certificates)}
  it { should have_many(:tickets)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:launch)}
  it { should have_one_attached(:template)}
  it { should have_one_attached(:certificate_template)}
end
