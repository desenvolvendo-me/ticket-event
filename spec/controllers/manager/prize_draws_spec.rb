require 'rails_helper'

RSpec.describe Manager::PrizeDrawsController, type: :controller do

  describe 'Test controller' do
    let(:event) { create(:event) }
    let(:ticket) { create(:ticket) }
    let(:prize_draw) { PrizeDraw.create(name: 'Bootcamp', date: DateTime.now, prize: 'Mouse', event: event, ticket: ticket) }

    context "GET /index" do
      it "return response successful" do
        get :index, params: {event_id: event.id}
        expect(response).to  be_successful
      end
    end

    context 'GET /new' do
      it 'returns a successful response' do
        get :new, params: {event_id: event.id}
        expect(response).to be_successful
        expect(prize_draw.ticket.id).to eq(ticket.id)
      end
    end

    describe "POST /create" do
      let(:prize_draw_params) do
        { name: 'Bootcamp', date: DateTime.now, prize: 'Mouse', event_id: event.id, ticket_id: ticket.id }
      end
      it 'with valid params' do
        post :create, params: { event_id: event.id, prize_draw: prize_draw_params }
        expect(response).to be_successful
        expect(PrizeDraw.count).to eq(1)
        expect(PrizeDraw.first.name).to eq('Bootcamp')
        expect(PrizeDraw.first.ticket_id).to eq(ticket.id)
      end
    end

    context "GET /show" do
      it 'returns a successful response' do
        get :show, params: { event_id: event.id, id: prize_draw.id}
        expect(response).to be_successful
        expect(prize_draw.name).to eq('Bootcamp')
        expect(prize_draw.ticket.id).to eq(ticket.id)
      end
    end

    context 'GET /edit' do
      it 'with valid params' do
        get :edit, params: { event_id: event.id, id: prize_draw.id }
        expect(response).to be_successful
      end
    end

    describe 'PUT /update' do
      let(:updated_prize_draw_params) do
        {name: 'Bootcamp 2024', prize: 'Teclado', ticket_id: create(:ticket).id}
      end
      it 'with valid params' do
        put :update, params: { event_id: event.id, id: prize_draw.id, prize_draw: updated_prize_draw_params }

        prize_draw.reload
        expect(prize_draw.name).to eq('Bootcamp 2024')
        expect(prize_draw.prize).to eq('Teclado')
      end
    end

    context 'DEL /destroy' do
      it 'should destroy a event' do
        delete :destroy, params: { event_id: event.id, id: prize_draw.id }

        expect { prize_draw.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end


