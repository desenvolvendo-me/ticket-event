class Manager::LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :set_event_options, only: [:new, :create, :edit, :update]

  def index
    @lessons = Lesson.all
  end
  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      redirect_to manager_lesson_path(@lesson)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to manager_lesson_path(@lesson)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @lesson.destroy
    redirect_to manager_lessons_path
  end

  private

  def lesson_params
    params.require(:lesson).permit(:link, :title, :description, :launch_datetime, :thumbnail, :event_id)
  end

  def set_event_options
    @event_options = Event.all.map { |e| [e.name, e.id] }
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
end
