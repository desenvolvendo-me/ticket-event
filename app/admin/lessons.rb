ActiveAdmin.register Lesson do
  permit_params :link, :event_id, :title, :description

  index do
    selectable_column
    id_column
    column :event
    column :title
    column :description
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
      row :link do |lesson|
        link_to lesson.link, lesson.link, target: '_blank'
      end
    end
  end
  form do |f|
    f.inputs "Lesson Details" do
      f.input :event
      f.input :link
      f.input :title
      f.input :description
    end
    f.actions
  end

end
