module Manager
  class StudentsController < ApplicationController
    before_action :set_student, only: %i[show edit update destroy]

    def index
      @students = Student.all
    end

    def show; end

    def new
      @student = Student.new
    end

    def edit; end

    def create
      @student = Student.new(student_params)

      return render :new unless @student.save

      redirect_to manager_students_url, notice: "Student was successfully created."
    end

    def update
      return render :edit, status: :unprocessable_entity unless @student.update(student_params)

      redirect_to manager_student_url(@student), notice: "Student was successfully updated."
    end

    def destroy
      @student.destroy

      redirect_to manager_students_url, notice: "Student was successfully destroyed."
    end

    private

    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:email, :name, :phone, :profile_social, :type_social)
    end
  end
end
