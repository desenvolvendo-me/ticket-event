class TicketsController < ApplicationController
  layout "external"

  before_action :get_ticket, :only => [:ticket, :form, :update]

  def ticket
  end

  def search
    @slug_event = params[:slug_event]
  end

  def form
    if @ticket
      redirect_to event_ticket_path(@ticket.event.slug, @ticket.student.phone)
    else
      redirect_to search_ticket_path(params["slug_event"]), notice: "O número não foi cadastrado nesse evento!"
    end
  end

  def edit
    @student = Student.find_by_phone(params["phone"])
  end

  def update
    @student = Student.find_by_phone(params["phone"])
    @student.update(profile_social: params["profile_social"], type_social: params["type_social"], avatar: params["avatar"])

    Tickets::Builder.call(ticket: @ticket)

    redirect_to event_ticket_path(params["slug_event"], params["phone"])
  end

  def get_ticket
    @ticket = Ticket.joins(:event, :student)
                    .where(events: { slug: params["slug_event"] }, students: { phone: params["phone"] }).take
  end
end
