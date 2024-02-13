module Manager
  class StudentsController < ApplicationController
    before_action :set_student, only: %i[show edit update destroy select_event]

    def index
      @students = Student.all.all
    end

    def show; end

    def new
      @student = Student.new
    end

    def edit; end

    def create
      @student = Student.new(student_params)
      unless @student.save
        render :new
        return
      end
      notice_message = t('controllers.manager.students.notices.student_created')
      redirect_to manager_students_url, notice: notice_message
      #return render :new unless @student.save
      #redirect_to manager_students_url, notice: t('controllers.manager.students.notices.student_created')
    end

    def update
      return render :edit, status: :unprocessable_entity unless @student.update(student_params)

      redirect_to manager_student_url(@student), notice: t('controllers.manager.students.notices.student_updated')
    end

    def destroy
      @student.destroy
      notice_message = t('controllers.manager.students.notices.student_destroyed')
      redirect_to manager_students_url, notice: notice_message
      #redirect_to manager_students_url, notice: t('controllers.manager.students.notices.student_destroyed')
    end

    def select_student_csv
      @student = Student.new
    end

    def import_student_csv
      Students::BatchCreator.call(csv_path: student_params[:file].path)

      notice_message = t('controllers.manager.students.notices.registered_students')
      redirect_to manager_students_url, notice: notice_message
      #redirect_to manager_students_url, notice: t('controllers.manager.students.notices.registered_students')
    end

    def select_event; end

    def create_certificate
      event = Event.find(params[:certificate][:event_id])
      student = Student.find(params[:id])
      
      certificate_data = {student_id: student.id, event_id: event.id}
      Certificates::CratetionWorker.perform_async(certificate_data)
      #certificate = Certificate.create(student_id: student.id, event_id: event.id)
      #Certificates::Builder.call(certificate: certificate)

      redirect_to manager_students_url, notice: t('active_admin.notice.student.certificate_generated_successfully')
      # TODO: Once Manager::Certificate resources are implemented, change redirect to the Certificate index instead Students
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
