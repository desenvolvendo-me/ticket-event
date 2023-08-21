class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:ticket, :search, :form]
  layout "ticket"

  def ticket
    @ticket ||= Ticket.includes(:event, :student)
                      .where(events: { slug: params["slug_event"] }, students: { phone: params["phone"] }).take
  end

  def search
    @slug_event = params[:slug_event]
  end

  def form
    ticket = Ticket.joins(:event, :student)
                   .where(events: { slug: params["slug_event"] }, students: { phone: params["phone"] }).take
    if ticket
      redirect_to event_ticket_path(ticket.event.slug, ticket.student.phone )
    else
      redirect_to search_ticket_path(params["slug_event"]), notice: "O número não foi cadastrado nesse evento!"
    end
  end
end
