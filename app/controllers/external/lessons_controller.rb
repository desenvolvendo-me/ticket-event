class External::LessonsController < ExternalController
  before_action :set_event, only: %i[ index show ]
  before_action :get_ticket, only: %i[ form ]
  before_action :get_lesson, only: [ :show ]
  before_action :get_video_embedder, only: %i[ index show ]
  before_action :authenticate_student_user!, only: :get_student
  def index
    @lessons = @event.lessons
    @lessons_checker = []
    @lessons.each_with_index do |lesson, index|
      @lessons_checker[index] = Access::Checker.call(lesson)
    end
    @video_embedder = Lessons::Embedder
    get_student
    check_lesson
    first_time_class
  end

  def show
    @purchase = Access::Checker.call(@event, :purchase)
    @lesson_checker = Access::Checker.call(@lesson)
    get_student
    check_lesson
    first_time_class
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
    unless student_has_watched
      lessons_and_student = @lesson_ids.map.with_index do |lesson_id, index|
        status = index == 0 ? 'progress' : 'not started'
        { student_id: @student_data.id, lesson_id: lesson_id, status: status}
      end

      StudentLesson.insert_all(lessons_and_student)
      redirect_back(fallback_location: lessons_index_path)
    end
  end

  def student_has_watched
    @lesson_ids = Lesson.where(event_id: @event).pluck(:id)
    return @student_watched = StudentLesson.where(student_id: @student_data, lesson_id: @lesson_ids).exists?
  end

  def check_lesson
    @status_lesson = StudentLesson.where(student_id: @student_data, lesson_id: @lesson).pluck(:status)

    if @status_lesson[0] == "progress"
      return @status_lesson == "progress"
    elsif @status_lesson[0] == "finished"
      return @status_lesson == "finished"
    else
      return @status_lesson[0] == "not started"
    end

  end

  def terminate_lesson
    @student_lesson = StudentLesson.find_by(student_id: get_student, lesson_id: params[:lesson_id])
    if @student_lesson
      @student_lesson.update(status: "finished")
      @new_lesson = StudentLesson.where(student_id: get_student, lesson_id: (params[:lesson_id].to_i + 1)).exists?
      if @new_lesson
        @new_lesson = StudentLesson.find_by(student_id: get_student, lesson_id: (params[:lesson_id].to_i + 1))
        @new_lesson.update(status: "progress")
        #redirect_to lesson_path(params[:slug_event], params[:lesson_id])
        #redirect_back(fallback_location: lesson_path(params[:slug_event], params[:lesson_id]))
        #redirect_to request.referrer
      end
    else
      puts "O SQL não deu certo"
    end
    #head :ok
    redirect_to lesson_url(params[:slug_event], params[:lesson_id])
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
    if student_user_signed_in?
      @student = current_student_user
      return @student_data = @student.student
    end
  end
end
