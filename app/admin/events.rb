ActiveAdmin.register Event do
  permit_params :name, :launch, :description, :date, :template

  index do
    id_column
    column :name
    column :launch
    column :description
    column :date
    column :slug
    actions
  end

  show :title => proc {|event| event.name }do
    attributes_table do
      row :name
      row :launch
      row :description
      row :date
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
      f.input :launch
      f.input :description
      f.input :date
      f.input :template, as: :file
    end
    f.actions
  end

  controller do
    defaults :finder => :find_by_slug
  end

end
