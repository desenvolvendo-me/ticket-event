# frozen_string_literal: true

module Manager
  class PrizeDrawsController < ApplicationController
    before_action :set_prize_draw, only: %i[index show new edit create update destroy prize_draw_winner]
    before_action :set_event

    def index
      @prize_draws = PrizeDraw.all
    end

    def show
      @prize_draws = PrizeDraw.find_by(id: params[:id])
    end

    def new
      @prize_draw = PrizeDraw.new
    end

    def create
      @prize_draw = @event.create_prize_draw(prize_draw_params)
      render :new unless @prize_draw.save

      redirect_to manager_event_prize_draws_path(event_id: @event, id: @prize_draw)
    end

    def edit; end

    def update
      render :edit unless @prize_draw.update(prize_draw_params)
      redirect_to manager_event_prize_draw_path(@event, @prize_draw)
    end

    def destroy
      @prize_draw.destroy
      redirect_to manager_event_prize_draws_path
    end

    def prize_draw_winner
      @prize_draw = PrizeDraw.find(params[:id])
      @ticket = Ticket.find(params[:id])
      @prize_draw= PrizeDraws::Generator.new(@event, @prize_draw).call

      if @prize_draw.present?
        render :prize_draw_winner
      else
        redirect_to manager_event_prize_draws_path
      end
    end

    private

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_prize_draw
      @prize_draw = PrizeDraw.find_by(id: params[:id])
    end

    def prize_draw_params
      params.require(:prize_draw).permit(:name, :date, :prize, :event_id, :ticket_id)
    end
  end
end