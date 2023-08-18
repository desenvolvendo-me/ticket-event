ActiveAdmin.register Event do
  permit_params :description, :info, :template

  show do
    attributes_table do
      row :description
      row :info

      row :template do |event|
        if event.template.attached?
          image_tag(event.template, size: "300x300")
        else
          "Nenhuma imagem anexada."
        end
      end
    end
  end

  form do |f|
    f.inputs "Firmware" do
      f.input :description
      f.input :info
      f.input :template, as: :file
    end
    f.actions
  end

end
