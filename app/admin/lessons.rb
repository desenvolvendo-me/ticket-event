ActiveAdmin.register Lesson do
  permit_params :link, :event_id

  index do
    selectable_column
    id_column
    column :event
    column :link do |lesson|
      link_to lesson.link, lesson.link, target: '_blank'
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :event
      row :link do |lesson|
        link_to lesson.link, lesson.link, target: '_blank'
      end
    end
  end
end
