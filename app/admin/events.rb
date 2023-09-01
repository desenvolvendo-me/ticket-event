ActiveAdmin.register Event do
  permit_params :name, :launch, :description, :date, :template, :certificate_template

  index do
    id_column
    column :name
    column :checked do |event|
      event.tickets.where(checkin: true).count
    end
    column :launch
    column :description
    column :date
    column :slug do |event|
      link_to event.slug, search_ticket_path(event), target: "_blank"
    end
    actions
  end

  show :title => proc {|event| event.name }do
    attributes_table do
      row :name
      row :checked do |event|
        event.tickets.where(checkin: true).count
      end
      row :launch
      row :description
      row :date
      row :slug do |event|
        link_to event.slug, search_ticket_path(event), target: "_blank"
      end

      row :template do |event|
        if event.template.attached?
          image_tag(event.template, size: "300x300")
        else
          "Nenhuma imagem anexada."
        end
      end

      row :certificate_template do |event|
        if event.certificate_template.attached?
          image_tag(event.certificate_template, size: "300x300")
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
      f.input :certificate_template, as: :file
    end
    f.actions
  end

  controller do
    defaults :finder => :find_by_slug
  end

  action_item :select_template_ticket, :only => :show do
    link_to t("active_admin.actions.select_template_ticket"), :action => 'select_template_ticket'
  end

  member_action :select_template_ticket, title: I18n.t("active_admin.actions.select_template_ticket") , only: :show do

  end

  member_action :set_template_ticket, :method => :post do
    template_ticket = TemplateTicket.find(params[:event][:template_ticket_id])
    resource.template.attach(template_ticket.svg.blob)

    redirect_to :action => :index, :notice => t("active_admin.notice.event.select_template_ticket")
  end

end
