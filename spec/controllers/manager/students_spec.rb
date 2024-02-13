require 'rails_helper'

RSpec.describe Manager::StudentsController type controller do
  let!(:manager_user) { create(:manager_user) }

  before(:each) do
    sign_in manager_user
  end

  describe "GET /index" do
    it 'should returns a successful response' do
      get :index, params: {event_id: event.id}
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it 'should returns a successful response' do
      get :new, params: {event_id: event.id}
    end
  end

  describe "GET /show" do
    it 'should returns a successful response' do
      student = create(:student)
      get :show, params: {event_id: event.id, id: student.id}
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it 'Should returns a successful response' do
      event = create(:event)
      get :edit, params: {event_id: event.id, id: student.id }
      expect(response).to be_successful
    end
  end

  describe "PUT /update" do
    it "Updates a student with a new title" do
      student = create(:student)
      patch :update, params: {id: student.id, lesson: {title: "Updated Title"}}
      expect(student.name).to eq("Update Title")
      expect(response).to redirect_to(manager_student_path(success))
    end
  end

  describe "DEL /destroy" do
    it 'Should destroy a event' do
      student = create(:student)
      expect{
        delete :destroy, params: {id: student.id}
      }.to change(Student, :count).by(-1)
      expect(response).to redirect_to(manager_student_path)  
    end
  end
  
  describe "GET /select_student_csv" do
    it 'should returns a successful response' do
      get :select_student_csv
      expect(response).to be_successful
    end
  end

  describe "POST /import_student_csv" do
    it 'should generate student and redirects to the index' do
      event = create(:event)
      expect{
        post :import_student_csv, params: { student: {event_id: event.id, file: "spec/support/leads_export.csv"}}
      }.to change(Student, :count).by(1)

      expect(response).to redirect_to(action: :index)
    end
  end  
end