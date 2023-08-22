ActiveAdmin.register Event do
  permit_params :name, :description, :info, :template, :slug

  show :title => :name do
    attributes_table do
      row :name
      row :description
      row :info
      row :slug

      row :template do |event|
        if event.template.attached?
          image_tag(event.template, size: "300x300")
        else
          "Nenhuma imagem anexada."
        end
      end
    end
  end

  form :title => :name do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :info
      f.input :slug
      f.input :template, as: :file
    end
    f.actions
  end

  controller do
    defaults :finder => :find_by_slug
  end

end
