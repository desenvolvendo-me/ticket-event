ActiveAdmin.register CertificateTemplate do
  permit_params :description, :name, :version, :svg

  index do
    id_column
    column :name
    column :description
    column :version
    column :svg do |template|
      if template.svg.attached?
        link_to image_tag(template.svg, size: "50x25"), template.svg
      end
    end
    actions
  end

  form title: :name do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :version
      f.input :svg, as: :file
    end
    f.actions
  end

  show title: :name do
    attributes_table do
      row :name
      row :description
      row :version
      row :svg do |template|
        if template.svg.attached?
          link_to image_tag(template.svg, size: "300x300"), template.svg
        else
          t("active_admin.actions.not_image")
        end
      end
    end
  end
end
