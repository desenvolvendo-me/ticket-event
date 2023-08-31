ActiveAdmin.register Ticket do
  permit_params :event_id, :student_id
  actions :index, :show

  index do
    id_column
    column :student
    column :event
    column :send_email_at
    column :checkin
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
      row :send_email_at
      row :checkin
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

  action_item :select_student_csv, :only => :index do
    link_to t("active_admin.actions.select_student_csv"), :action => 'select_student_csv'
  end

  collection_action :select_student_csv, title: I18n.t("active_admin.actions.select_student_csv"), only: :index do

  end

  collection_action :import_student_csv, :method => :post do
    event = Event.find(params[:ticket][:event_id])
    Tickets::Builder.call({ event: event, csv_path: params["ticket"]["file"] })
    redirect_to :action => :index, :notice => t("active_admin.notice.ticket.select_student_csv")
  end

  action_item :send_email, only: :show do
    link_to t("active_admin.actions.send_email"), send_email_admin_ticket_path(resource), method: :put
  end

  member_action :send_email, method: :put do
    Notifications::Notifier.call(ticket: resource)

    redirect_to admin_ticket_path(resource), :notice => t("active_admin.notice.ticket.email")
  end

  action_item :send_emails, only: :index do
    link_to t("active_admin.actions.send_emails"), send_emails_admin_tickets_path, method: :post
  end

  collection_action :send_emails, method: :post do
    Notifications::Notifier.call

    redirect_to admin_tickets_path, :notice => t("active_admin.notice.ticket.emails")
  end

end
