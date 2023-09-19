class LessonsController < ExternalController
  before_action :set_event, only: [:index]
  def index
    @lessons = @event.lessons
    @video_embedder = Lessons::Embedder
  end


  private

  def set_event
    @event = Event.find_by(slug: params[:slug_event])
  end
end
