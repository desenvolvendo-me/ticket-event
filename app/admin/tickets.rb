ActiveAdmin.register Ticket do
  permit_params :event_id, :student_id

  show do
    attributes_table do
      row :event
      row :student

      row :svg do |ticket|
        if ticket.svg.attached?
          image_tag(ticket.svg, size: "300x300")
        else
          "Nenhuma imagem anexada."
        end
      end

      row :png do |ticket|
        if ticket.svg.attached?
          image_tag(ticket.svg, size: "300x300")
        else
          "Nenhuma imagem anexada."
        end
      end
    end
  end

  action_item :only => :index do
    link_to "Importar CSV", :action => 'upload_csv'
  end

  collection_action :upload_csv do

  end

  collection_action :import_csv, :method => :post do
    event = Event.find(params[:ticket][:event_id])
    Tickets::Builder.call({ event: event, csv_path: params["ticket"]["file"] })
    redirect_to :action => :index, :notice => "CSV Enviado para Importação com Sucesso!"
  end
end
