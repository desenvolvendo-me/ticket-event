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
        return t("active_admin.actions.not_image") unless certificate.svg.attached?

        link_to image_tag(certificate.svg, size: "200x100"), certificate.svg
      end

      row :png do |certificate|
        return t("active_admin.actions.not_image") unless certificate.png.attached?

        link_to image_tag(certificate.svg, size: "200x100"), certificate.png
      end
    end
  end
end
