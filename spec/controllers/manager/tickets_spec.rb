require 'rails_helper'

RSpec.describe Manager::TicketsController, type: :controller do
  let!(:manager_user) { create(:manager_user) }

  before(:each) do
    sign_in manager_user
  end

  describe 'GET /index' do
    it 'should returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'should returns a successful response' do
      ticket = create(:ticket)
      get :show, params: { id: ticket.id }
      expect(response).to be_successful
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
        post :import_student_csv, params: { ticket: { event_id: event.id, file: "spec/support/leads_export.csv" } }
      }.to change(Ticket, :count).by(1)

      expect(response).to redirect_to(action: :index)
    end
  end

 
end
