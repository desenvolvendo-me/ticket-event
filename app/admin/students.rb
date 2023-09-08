ActiveAdmin.register Student do
  permit_params :name, :email, :phone

  action_item :select_event, only: :show do
    link_to "Gerar certificado", action: "select_event", id: resource.id
  end

  collection_action :select_event, title: "Gerar certificado", only: :show do

  end

  collection_action :create_certificate, method: :post do
    event = Event.find(params[:certificate][:event_id])
    student = Student.find(params[:certificate][:student_id])
    certificate = Certificate.create(student_id: student.id, event_id: event.id)
    Certificates::Builder.call(certificate: certificate)

    redirect_to action: :index, notice: "Certificado gerado com sucesso!"
  end
end
