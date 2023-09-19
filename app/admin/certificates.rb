ActiveAdmin.register Certificate do
  permit_params :student_id, :event_id
  actions :index, :show

  index do
    id_column
    column :student
    column :event
    column :certificate do |certificate|
      if certificate.png.attached?
        link_to image_tag(certificate.png, size: "50x25"), certificate.png, target: "_blank"
      end
    end
    actions
  end
  
  show do
    attributes_table do
      row :student
      row :event
      row :svg do |certificate|
        if certificate.svg.attached?
          link_to image_tag(certificate.svg, size: "200x100"), certificate.svg
        else
          t("active_admin.actions.not_image")
        end
      end

      row :png do |certificate|
        if certificate.png.attached?
          link_to image_tag(certificate.png, size: "200x100"), certificate.png, target: "_blank"
        else
          t("active_admin.actions.not_image")
        end
      end
    end
  end
end
