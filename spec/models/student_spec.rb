require 'rails_helper'

RSpec.describe Student, type: :model do
  describe "associations" do
    it { should have_many(:tickets) }
    it { should have_many(:certificates).dependent(:destroy) }
    it { should have_one_attached(:avatar) }
  end

  describe "constants" do
    it "has the type social" do
      expect(Student::TYPE_SOCIAL).to contain_exactly("github", "aleatória")
    end
  end
end
