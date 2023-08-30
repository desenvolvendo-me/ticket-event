ActiveAdmin.register Lesson do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
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
  #
  # or
  #
  # permit_params do
  #   permitted = [:link, :event_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
