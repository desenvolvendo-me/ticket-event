require 'rails_helper'

RSpec.describe Manager::EventsController, type: :controller do
  describe 'GET /index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    it 'create a new event' do
      expect{ post :create, params:{
          event: {
            name:'bootcamp teste',
            description:'fazendo um descrição do evento!',
            date: DateTime.now,
            launch:1
          }
        }
      }.to change(Event, :count).by(1)
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      event = create(:event)
      get :show, params: { id: event.id }
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'returns a successful response' do
      event = create(:event)
      get :edit, params: {id: event.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH /update' do
    it 'update event with new name' do
      event = create(:event)
      patch :update, params: { id: event.id, event: { name: 'bootcamp other test!'} }
      event.reload
      expect(event.name).to eq('bootcamp other test!')
      expect(response).to redirect_to manager_event_path(event)
    end
  end

  describe 'DELETE /destroy' do
    it 'should destroy a event' do
      event = create(:event)
      expect {
        delete :destroy, params: { id: event.id }
      }.to change(Event, :count).by(-1)

      expect(response).to redirect_to(manager_events_path)
    end

  end
end