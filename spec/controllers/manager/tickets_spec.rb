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

  describe "POST #create" do
    context 'with valid parameters' do
      let(:event) { create(:event) }
      let(:student) { create(:student) }
      let(:valid_ticket_params) do
        {
          event_id: event.id,
          student_id: student.id,
          send_email_at: Date.today,
          checkin: false,
          student_answers: { 'question1' => 'answer1', 'question2' => 'answer2' }
        }
      end

      it 'creates a new ticket' do
        expect {
          post :create, params: { ticket: valid_ticket_params }
        }.to change(Ticket, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_ticket_params) { { event_id: nil, student_id: nil } }

      it 'does not create a new ticket' do
        expect {
          post :create, params: { ticket: invalid_ticket_params }
        }.not_to change(Ticket, :count)
      end

      it 'renders the new template' do
        post :create, params: { ticket: invalid_ticket_params }
        expect(response).to render_template(:new)
      end
    end
  end
end
