class Manager::EventsController < ApplicationController
  before_action :get_event, only: %i[ show new create edit update destroy ]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def show; end

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
      params.require(:event).permit(:name, :description, :date, :launch)
    end
end
