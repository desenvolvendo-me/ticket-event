class External::EventsController < ExternalController
  before_action :get_event
  before_action :authenticate_user!, except: [:index ]

  def index; end

  private

  def get_event
    @event = Event.find_by(params[:launch_and_name])
  end
end
