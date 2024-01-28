class External::LessonsController < ExternalController
  before_action :set_event, only: %i[ index show ]
  before_action :get_ticket, only: %i[ form ]
  before_action :get_lesson, only: [ :show ]
  before_action :get_video_embedder, only: %i[ index show ]
  before_action :get_student
  def index
    @lessons = @event.lessons
    @lessons_checker = []
    @lessons.each_with_index do |lesson, index|
      @lessons_checker[index] = Access::Checker.call(lesson)
    end
    @video_embedder = Lessons::Embedder
    first_time_class
  end

  def show
    @purchase = Access::Checker.call(@event, :purchase)
    @lesson_checker = Access::Checker.call(@lesson)
  end

  def search;  end

  def form
    if @ticket.save
      @lesson = Lesson.find(params[:lesson_id])
      redirect_to quiz_path(@lesson.event.slug, @lesson)
    else
      redirect_to lesson_validate_path(params["slug_event"]), notice: I18n.t('lesson.form.unable_record')
    end
  end

  def first_time_class
    # Obter todas as aulas de um evento
    @ids_lessons = Lesson.where(event_id: @event).pluck(:id)

    # Consultar para ver se há associações
    @result_exists = StudentLesson.where(student_id: @student_data, lesson_id: @ids_lessons).exists?

    # Popular a tabela com o id do estudante e com todas as aulas, aula 1 recebe progress
    unless @result_exists
      lessons_and_student = @ids_lessons.map.with_index do |lesson_id, index|
        status = index == 0 ? 'progress' : 'not started'
        { student_id: @student_data.id, lesson_id: lesson_id, status: status}
      end

      StudentLesson.insert_all(lessons_and_student)
    end
  end

  private

  def set_event
    @event = Event.find_by(slug: params[:slug_event])
  end

  def get_ticket
    if session[:student_phone].present?
      @ticket = Ticket.joins(:event, :student)
                      .where(events: { slug: params["slug_event"] }, students: { phone: session[:student_phone] }).take
    else
      store_student_phone
      get_ticket
    end
  end

  def store_student_phone
    session[:student_phone] = params["phone"]
  end

  def get_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def get_video_embedder
    @video_embedder = Lessons::Embedder
  end

  def get_student
    @student = current_student_user
    @student_data = @student.student
  end
end
