class EventsController < ApplicationController
  before_action :get_event, only: %i[ index event_detail ]
  def index
    @event_day = Event.all
  end

  def event_detail; end

  private
  def get_event
    @event_day = Event.friendly.find_by(params[:launch_and_name])
  end
end
