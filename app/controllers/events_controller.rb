class EventsController < ApplicationController
  before_action :get_event, only: %i[ index select_event ]
  def index
  end

  def select_event; end

  private
  def get_event
    @event_day = Event.friendly.find_by(params[:launch_and_name])
  end
end
