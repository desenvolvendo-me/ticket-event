ActiveAdmin.register Student do
  permit_params :name, :email, :phone

  action_item :select_event, only: :show do
    link_to t("active_admin.actions.generate_certificate"), action: "select_event", id: resource.id
  end

  collection_action :select_event, title: I18n.t("active_admin.actions.generate_certificate"), only: :show do

  end

  collection_action :create_certificate, method: :post do
    event = Event.find(params[:certificate][:event_id])
    student = Student.find(params[:certificate][:student_id])
    certificate = Certificate.create(student_id: student.id, event_id: event.id)
    Certificates::Builder.call(certificate: certificate)

    redirect_to action: :index, notice: t("active_admin.notice.student.certificate_generated_successfully")
  end
end
