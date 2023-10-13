require 'rails_helper'

RSpec.describe Manager::TicketsController, type: :controller do
  describe 'GET /index' do
    it 'should returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'should returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    it 'should returns a successful response' do
      event = create(:event)
      student = create(:student)

      expect {
        post :create, params: { ticket: {event_id: event.id, student_id: student.id}}
      }.to change(Ticket, :count).by(1)
    end
  end
end
