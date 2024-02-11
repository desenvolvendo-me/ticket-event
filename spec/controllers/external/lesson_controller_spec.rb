require 'rails_helper'

RSpec.describe External::LessonsController, type: :controller do
  describe '#get_student' do
    let(:student_user) { FactoryBot.create(:student_user) }
    let(:student) { FactoryBot.create(:student, student_user: student_user) }

    before do
      allow(controller).to receive(:current_student_user).and_return(student_user)
      allow(controller).to receive(:authenticate_student_user!).and_return(true)
      allow(controller).to receive(:get_student)
    end

    it 'assigns the student data when student is signed in' do
      sign_in student_user
      controller.send(:get_student)
      expect(assigns(:student_data)).to eq(student_user.student)
      expect(controller.instance_variable_get(:@student_data)).to eq(student_user.student)
    end

    it 'does not assign student data when student is not signed in' do
      allow(controller).to receive(:current_student_user).and_return(nil)
      expect(controller.send(:get_student)).to be_nil
    end
  end
end
