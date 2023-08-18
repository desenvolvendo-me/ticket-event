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

end
