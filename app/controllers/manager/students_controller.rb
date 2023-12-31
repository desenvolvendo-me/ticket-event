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

      redirect_to manager_students_url, notice: t("controllers.manager.students.notices.student_created")
    end

    def update
      return render :edit, status: :unprocessable_entity unless @student.update(student_params)

      redirect_to manager_student_url(@student), notice: t("controllers.manager.students.notices.student_updated")
    end

    def destroy
      @student.destroy

      redirect_to manager_students_url, notice: t("controllers.manager.students.notices.student_destroyed")
    end

    def select_student_csv
      @student = Student.new
    end

    def import_student_csv
      Students::BatchCreator.call(csv_path: student_params[:file])

      redirect_to manager_students_url, notice: t("controllers.manager.students.notices.registered_students")
    end

    private

    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:email, :name, :phone, :profile_social, :type_social, :file)
    end
  end
end
