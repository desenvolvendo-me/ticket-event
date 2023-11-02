class External::EventsController < ExternalController
  before_action :get_event

  def index
    @event_checker = Access::Checker.call(@event, :date)
  end

  private

  def get_event
    @event = Event.find_by(params[:launch_and_name])
  end
end
