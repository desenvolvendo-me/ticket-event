class External::EventsController < ExternalController
  before_action :get_event

  def index
    result = Access::Checker.new(@event)
    @event_checker = result.call
  end

  private

  def get_event
    @event = Event.find_by(params[:launch_and_name])
  end
end
