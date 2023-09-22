class LessonsController < ExternalController
  before_action :set_event, only: [:index]
  before_action :get_ticket, only: %i[ form ]
  def index
    @lessons = @event.lessons
    @video_embedder = Lessons::Embedder
  end

  def search
  end

  def form
    if @ticket.save
      @lesson = Lesson.find(params[:lesson_id])
      @ticket = @ticket
      redirect_to quiz_path(@lesson.event.slug, @lesson)
    else
      redirect_to lesson_validate_path(params["slug_event"]), notice: "O número não foi cadastrado nesse evento!"
    end
  end

  private

  def set_event
    @event = Event.find_by(slug: params[:slug_event])
  end

  def get_ticket
    @ticket = Ticket.joins(:event, :student)
                    .where(events: { slug: params["slug_event"] }, students: { phone: params["phone"] }).take
  end
end
