# == Schema Information
#
# Table name: student_users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_student_users_on_email                 (email) UNIQUE
#  index_student_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe StudentUser, type: :model do
  describe 'associations' do
    it { should have_one(:student).dependent(:destroy) }
  end

  describe 'callbacks' do
    describe 'create_associated_student_if_not_exists' do
      context 'when a student with the same email does not exist' do
        it 'creates a new student' do
          student_user = FactoryBot.create(:student_user)
          expect(Student.count).to eq(1)
          expect(Student.first.email).to eq(student_user.email)
          expect(Student.first.student_user_id).to eq(student_user.id)
        end
      end

      context 'when a student with the same email already exists' do
        it 'does not create a new student' do
          existing_student = FactoryBot.create(:student)
          student_user = FactoryBot.create(:student_user, email: existing_student.email)
          expect(Student.count).to eq(1)
        end
      end
    end
  end
end
