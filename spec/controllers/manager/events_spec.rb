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
    let!(:event) { create(:event) }

    it 'update event with new name' do
      patch :update, params: { id: event.slug, event: { name: 'bootcamp other test!'} }
      event.reload
      expect(event.name).to eq('bootcamp other test!')
      expect(response).to redirect_to manager_event_path(event)
    end
  end

  describe 'DELETE /destroy' do
    let!(:event) { create(:event) }

    it 'should destroy a event' do
      expect {
        delete :destroy, params: { id: event.slug }
      }.to change(Event, :count).by(-1)

      expect(response).to redirect_to(manager_events_path)
    end
  end

  describe "POST /run_prize_draw" do
    let!(:event) { create(:event) }
    let!(:student) { create(:student) }
    let!(:ticket) { create(:ticket, student: student, event: event, student_score: 70) }

    it "generates prize draw" do
      expect { post :run_prize_draw, params: { id: event.slug } }
        .to change(PrizeDraw, :count).by(1)
    end
  end
end