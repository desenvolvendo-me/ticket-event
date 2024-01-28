# == Schema Information
#
# Table name: students
#
#  id              :bigint           not null, primary key
#  email           :string
#  name            :string
#  phone           :string
#  profile_social  :string
#  type_social     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  student_user_id :bigint
#
# Indexes
#
#  index_students_on_student_user_id  (student_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_user_id => student_users.id)
#
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
