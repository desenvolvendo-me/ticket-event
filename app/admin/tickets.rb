ActiveAdmin.register Ticket do
  permit_params :event_id, :student_id

  index do
    id_column
    column :student
    column :event
    column :ticket do |ticket|
      if ticket.png.attached?
        link_to image_tag(ticket.png, size: "50x25"), ticket.png, target: "_blank"
      end
    end
    actions
  end

  show do
    attributes_table do
      row :event
      row :student

      row :svg do |ticket|
        if ticket.svg.attached?
          link_to image_tag(ticket.svg, size: "200x100"), ticket.svg
        else
          "Nenhuma imagem anexada."
        end
      end

      row :png do |ticket|
        if ticket.svg.attached?
          link_to image_tag(ticket.png, size: "200x100"), ticket.png, target: "_blank"
        else
          "Nenhuma imagem anexada."
        end
      end
    end
  end

  action_item :upload_csv, :only => :index do
    link_to "Importar CSV", :action => 'upload_csv'
  end

  collection_action :upload_csv, only: :index do

  end

  collection_action :import_csv, :method => :post do
    event = Event.find(params[:ticket][:event_id])
    Tickets::Builder.call({ event: event, csv_path: params["ticket"]["file"] })
    redirect_to :action => :index, :notice => "CSV Enviado para Importação com Sucesso!"
  end

  action_item :send_email, only: :show do
    link_to "Enviar Email", send_email_admin_ticket_path(resource), method: :put
  end

  member_action :send_email, method: :put do
    Notifiers::Email.call(ticket: resource)

    redirect_to admin_ticket_path(resource), :notice => "Email Enviado!"
  end

  action_item :send_emails, only: :index do
    link_to "Enviar Emails", send_emails_admin_tickets_path, method: :post
  end

  collection_action :send_emails, method: :post do
    Notifiers::Email.call

    redirect_to admin_tickets_path, :notice => "Solicitação de Emails Enviado!"
  end

end
