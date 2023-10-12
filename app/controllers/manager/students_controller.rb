module Manager
  class StudentsController < ApplicationController

    def index
      @students = Student.all
    end
    def new
      @student = Student.new
    end

    def create
      @student = Student.new(student_params)

      return render :new unless @student.save

      redirect_to manager_students_path, notice: 'Student was successfully created.'
    end

    private

    def student_params
      params.require(:student).permit(:email, :name, :phone, :profile_social, :type_social)
    end
  end
end
