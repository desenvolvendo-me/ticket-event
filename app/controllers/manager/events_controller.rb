# manager/events_controller.rb
class Manager::EventsController < ApplicationController
  before_action :get_event, only: %i[ show new create edit update destroy]

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result(distinct: true).order(created_at: :asc)
  end
  def new
    @event = Event.new
  end

  def show
    @event = Event.includes(:prize_draw).friendly.find(params[:id])
  end

  def edit; end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to manager_event_url(@event)
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to manager_event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    if @event.destroy
      redirect_to manager_events_path
    end
  end

  private

  def get_event
    @event = Event.find_by(slug: params[:id])
  end

  def event_params
    params.require(:event).permit(
      :name, :description, :date, :launch, :community_link,
      :purchase_link, :purchase_date, :image, :duration,
      :is_visible_to_registered_participants,
      :is_visible_after_time, :visible_after_time, :is_visible_during_event
    )
  end
end
