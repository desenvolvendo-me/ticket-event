class External::CheckinsController < ExternalController

  before_action :get_ticket, :only => [:checked, :form]

  def checked
  end

  def search
    @slug_event = params[:slug_event]
    @event = Event.find_by_slug(@slug_event)
  end

  def form
    @ticket.update(checkin: true)

    redirect_to checked_checkin_path(@ticket.event.slug, @ticket.student.phone)
  end

  def get_ticket
    @ticket = Ticket.joins(:event, :student)
                    .where(events: { slug: params["slug_event"] }, students: { phone: params["phone"] }).take
  end
end
