class External::LessonsController < ExternalController
  before_action :set_event, only: %i[ index show ]
  before_action :get_ticket, only: %i[ form ]
  before_action :get_lesson, only: [ :show ]
  before_action :get_video_embedder, only: %i[ index show ]
<<<<<<< HEAD
  before_action :get_student
=======
  before_action :get_student_user
  before_action :lesson_is_conclude?
>>>>>>> parent of 92e3119 (chore(revert): start a new devlopment about to commit from 5/01/24)
  def index
    @lessons = @event.lessons
    @lessons_checker = []
    @lessons.each_with_index do |lesson, index|
      @lessons_checker[index] = Access::Checker.call(lesson)
    end
    @video_embedder = Lessons::Embedder
  end

  def show
    @purchase = Access::Checker.call(@event, :purchase)
    @lesson_checker = Access::Checker.call(@lesson)
    @lesson_status = lesson_is_conclude?
    @next_lesson = get_next_lesson
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

  def conclude_lesson
    slug_event = params[:slug_event]
    event_id = params[:event_id]
    lesson_id = params[:lesson_id]
    student_id = params[:student_id]

    lesson_status = StudentEventLessonStatus.new(
      event_id: event_id,
      student_id: student_id,
      lesson_id: lesson_id,
      is_finished: true
    )

    if lesson_status.save
      render json: { message: 'Dados gravados com sucesso!' }
    else
      render json: { error: 'Erro ao gravar os dados no banco de dados'}
    end

  end

  def lesson_is_conclude?
    if get_student_user
      @lesson_status = StudentEventLessonStatus.exists?(
        event_id: set_event,
        student_id: @student_user.student.id,
        lesson_id: @lesson,
        is_finished: true)

      if @lesson_status
        return true
      else
        return false
      end
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

  def get_next_lesson
    @last_lesson = Lesson.order(id: :desc).first
    if @lesson.id == @last_lesson.id
      @next_lesson = @last_lesson
    else
      @next_lesson = Lesson.find_by(id: (@lesson.id + 1))
    end
  end

  def get_video_embedder
    @video_embedder = Lessons::Embedder
  end

<<<<<<< HEAD
  def get_student
    @student_user = current_student_user
  end
end
=======
  def get_student_user
    @student_user = current_student_user
  end
<<<<<<< HEAD

  def verify_access_lesson
    if get_student_user
      if lesson_is_conclude?
        redirect_to lessons_index_path, notice: I18n.t('lesson.access.lock')
      end
    end
  end
end
>>>>>>> parent of 92e3119 (chore(revert): start a new devlopment about to commit from 5/01/24)
=======
end
>>>>>>> parent of 70d54dc (feat(lesson): restricting completed class times)
