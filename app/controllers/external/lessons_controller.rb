class External::LessonsController < ExternalController
  before_action :set_event, only: %i[ index show ]
  before_action :get_ticket, only: %i[ form ]
  before_action :get_lesson, only: [ :show ]
  before_action :get_video_embedder, only: %i[ index show ]
  before_action :authenticate_student_user!, only: :get_student

  helper_method :is_lesson_finished
  def index
    @lessons = @event.lessons
    @lessons_checker = []
    @lessons.each_with_index do |lesson, index|
      @lessons_checker[index] = Access::Checker.call(lesson)
    end
    @video_embedder = Lessons::Embedder
    get_student
    check_lesson
    first_time_class(@event)
  end

  def show
    @purchase = Access::Checker.call(@event, :purchase)
    @lesson_checker = Access::Checker.call(@lesson)
    @is_first_lesson = is_first_lesson?(@lesson)
    @is_last_lesson = is_last_lesson?(@lesson)
    get_student
    check_lesson
    first_time_class(@event)
    get_next_lesson
    get_previous_lesson
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

  def first_time_class(event)
    if get_student
      unless student_has_watched
        lessons_and_student = @lesson_ids.map.with_index do |lesson_id, index|
          status = index == 0 ? 'progress' : 'not started'
          { student_id: @student_data.id, lesson_id: lesson_id, status: status}
        end

        StudentLesson.insert_all(lessons_and_student)
        redirect_back(fallback_location: lessons_index_path(event.slug))
      end
    end
  end

  def student_has_watched
    Lessons::CheckStudentLessonWatched.new(@student_data, @event).call
  end

  def check_lesson
    Lessons::GetStatus.new(@student_data, @lesson).call
  end

  def terminate_lesson
    student_user = current_student_user
    lesson_id = params[:lesson_id]

    Lessons::Terminator.call(student_user, lesson_id)

    redirect_to lesson_url(params[:slug_event], lesson_id)
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
    Lessons::GetStudent.new(student_user_signed_in?, current_student_user).call
  end

  def get_next_lesson
    @next_lesson = Lesson.find_by(id: (@lesson.id + 1), event_id: @event.id)

    if @next_lesson
      return @next_lesson = Lesson.find_by(id: (@lesson.id + 1), event_id: @event.id)
    else
      @next_lesson = @lesson
    end
  end

  def get_previous_lesson
    @previous_lesson = Lesson.find_by(id: (@lesson.id - 1), event_id: @event.id)

    if @previous_lesson
      return @previous_lesson
    else
      @previous_lesson = @event.lessons.first
    end
  end

  def is_first_lesson?(lesson)
    lesson.id == lesson.event.lessons.first.id
  end

  def is_last_lesson?(lesson)
    lesson.id == lesson.event.lessons.last.id
  end
end
