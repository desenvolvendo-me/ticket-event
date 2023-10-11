class Manager::EventsController < ApplicationController
  def index
    @info_events = Event.all
  end

  def new
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def get_event
      @info_event = Event.find_by(slug: params[:id])
    end
end
