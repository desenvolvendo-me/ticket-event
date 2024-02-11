require 'rails_helper'

RSpec.describe Manager::PrizeDrawsController, type: :controller do
  let!(:manager_user) { create(:manager_user) }

  before(:each) do
    sign_in manager_user
  end

  describe 'Test controller' do
    let(:event) { create(:event) }
    let(:ticket) { create(:ticket, prize_draw: prize_draw) }
    let(:prize_draw) { create(:prize_draw, event: event) }


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
      end
    end

    describe "POST /create" do
      let(:prize_draw_params) do
        { name: 'Bootcamp', date: DateTime.now, prize: 'Mouse', event_id: event.id }
      end

      it 'with valid params' do
        post :create, params: { event_id: event.id, prize_draw: prize_draw_params }
        expect(PrizeDraw.count).to eq(1)
        expect(PrizeDraw.name).to eq('PrizeDraw')
      end
    end

    context "GET /show" do
      it 'returns a successful response' do
        get :show, params: { event_id: event.id, id: prize_draw.id}
        expect(response).to be_successful
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
        {name: 'Bootcamp 2024', prize: 'Teclado'}
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



    context 'GET #prize_draw_winner' do
      it 'redirects to winner path when there is a winner' do
        allow(PrizeDraws::Generator).to receive(:new).with(event, prize_draw).and_return(double(call: ticket))

        get :prize_draw_winner, params: { event_id: event.id, id: prize_draw.id, ticket_id: ticket.id }
        expect(response).to have_http_status(:success)
      end

      it 'redirects to another path when there is no winner' do
        allow(PrizeDraws::Generator).to receive(:new).and_return(double(call: false))

        get :prize_draw_winner, params: { event_id: event.id, id: prize_draw.id, ticket_id: ticket.id }
        expect(response).to redirect_to(manager_event_prize_draws_path)
      end
    end
  end
end

