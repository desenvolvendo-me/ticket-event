require 'rails_helper'

RSpec.describe Manager::StudentsController, type: :controller do
  describe "GET /index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
    end

  describe "GET /new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "returns a successful response" do
      expect{ post :create, params: {
        student: { name: 'Marco A. Castro',
                   phone: '61991707479',
                   email: 'marcodotcastro@gmail.com',
                   profile_social: nil,
                   type_social: nil
        }
       }
      }.to change(Student, :count).by(1)
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      student = create(:student)
      get :show, params: { id: student.id }
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'returns a successful response' do
      student = create(:student)
      get :edit, params: { id: student.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH /update' do
    it 'update event with new name' do
      student = create(:student)
      patch :update, params: { id: student.id, student: { name: 'Cássio Santana'} }
      student.reload
      expect(student.name).to eq('Cássio Santana')
      expect(response).to redirect_to manager_student_path(student)
    end
  end

  describe 'DELETE /destroy' do
    it 'should destroy a event' do
      student = create(:student)
      expect {
        delete :destroy, params: { id: student.id }
      }.to change(Student, :count).by(-1)

      expect(response).to redirect_to(manager_students_path)
    end
  end

  describe 'GET /select_student_csv' do
    it 'should returns a successful response' do
      get :select_student_csv
      expect(response).to be_successful
    end
  end

  describe 'POST /import_student_csv' do
    it 'should generate ticket and redirects to the index' do
      event = create(:event)
      expect {
        post :import_student_csv, params: { student: { event_id: event.id, file: "spec/support/leads_export.csv" } }
      }.to change(Student, :count).by(1)

      expect(response).to redirect_to(action: :index)
    end
  end
end