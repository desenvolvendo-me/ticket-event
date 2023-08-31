ActiveAdmin.register TemplateTicket do

  permit_params :name, :description, :version, :svg

  index do
    id_column
    column :name
    column :description
    column :version
    column :svg do |template_ticket|
      if template_ticket.svg.attached?
        link_to image_tag(template_ticket.svg, size: "50x25"), template_ticket.svg, target: "_blank"
      end
    end
    actions
  end

  form :title => :name do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :version
      f.input :svg, as: :file
    end
    f.actions
  end

  show :title => proc {|event| event.name }do
    attributes_table do
      row :name
      row :description
      row :version
      row :svg do |event|
        if event.svg.attached?
          image_tag(event.svg, size: "300x300")
        else
          "Nenhuma imagem anexada."
        end
      end
    end
  end

end
