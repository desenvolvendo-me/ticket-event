ActiveAdmin.register Lesson do
  permit_params :link, :event_id, :title, :description, :launch_datetime,:thumbnail

  index do
    selectable_column
    id_column
    column :event
    column :title
    column :description
    column :launch_datetime
    column :link do |lesson|
      link_to lesson.link, lesson.link, target: '_blank'
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :event
      row :title
      row :description
      row :launch_datetime
      row :link do |lesson|
        link_to lesson.link, lesson.link, target: '_blank'
      end
      row :thumbnail do |lesson|
        image_tag lesson.thumbnail, style: 'max-width: 400px;' if lesson.thumbnail.attached?
      end
    end
  end

  form do |f|
    f.inputs  I18n.t('activeadmin.lesson.lesson_details') do
      f.input :event
      f.input :link
      f.input :title
      f.input :description
      f.input :launch_datetime
      f.input :thumbnail, as: :file
    end
    f.actions
  end

end
