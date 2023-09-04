ActiveAdmin.register Event do
  permit_params :name, :launch, :description, :date, :template, :certificate_template

  index do
    id_column
    column :name
    column :checked do |event|
      event.tickets.where(checkin: true).count
    end
    column :launch
    column :description
    column :date
    column :slug do |event|
      link_to event.slug, search_ticket_path(event), target: "_blank"
    end
    column :lessons_alert do |event|
      if event.lessons.count < 3
        I18n.t('event.alert_index')
      end
    end
    actions
  end

  show :title => proc {|event| event.name }do
    attributes_table do
      row :name
      row :checked do |event|
        event.tickets.where(checkin: true).count
      end
      row :launch
      row :description
      row :date
      row :slug do |event|
        link_to event.slug, search_ticket_path(event), target: "_blank"
      end

      row :template do |event|
        if event.template.attached?
          image_tag(event.template, size: "300x300")
        else
          "Nenhuma imagem anexada."
        end
      end

      row :certificate_template do |event|
        if event.certificate_template.attached?
          image_tag(event.certificate_template, size: "300x300")
        else
          "Nenhuma imagem anexada."
        end
      end
    end
  end

  form :title => :name do |f|
    f.inputs do
      f.input :name
      f.input :launch
      f.input :description
      f.input :date
      f.input :template, as: :file
      f.input :certificate_template, as: :file
    end
    f.actions
  end

  controller do
    defaults :finder => :find_by_slug
  end
end
