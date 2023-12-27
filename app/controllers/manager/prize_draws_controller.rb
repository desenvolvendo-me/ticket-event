class Manager::PrizeDrawsController < ApplicationController
  before_action :set_prize_draw, only: %i[ show edit update destroy run_prize_draw]
  before_action :set_event

  def index
    @event = Event.find(params[:event_id])
    @prize_draws = @event.prize_draw
  end

  def show; end

  def new
    @event =  Event.find(params[:event_id])
    @prize_draw = @event.prize_draw

  end

  def create
    @prize_draw = PrizeDraw.new(prize_draw_params)

    if @prize_draw.save
      redirect_to manager_event_prize_draws_path(event_id: @event, id: @prize_draw), notice: 'OK'
    else
      render :new
    end
  end


  def edit; end

  def update
    if @prize_draw.update(prize_draw_params)
      redirect_to manager_event_prize_draws_path(@prize_draw)
    else
      render :edit
    end
  end

  def destroy
    if @prize_draw.destroy
      redirect_to manager_event_prize_draws_path
    end
  end

  # def run_prize_draw
  #   generator = PrizeDraws::Generator.new(@event)
  #   winner_ticket = generator.call
  # end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end


  def set_prize_draw
    @prize_draw = @event.prize_draw.find(params[:id])
  end

  def prize_draw_params
    params.require(:prize_draw).permit(:name, :date, :prize)
  end
end
