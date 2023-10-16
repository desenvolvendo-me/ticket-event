class Manager::TicketsController < ApplicationController
  before_action :set_event_options, only: [:create, :select_student_csv]
  before_action :set_ticket, only: [:create, :select_student_csv]

  def index
    @tickets = Ticket.all
  end

  def select_student_csv
    @ticket = Ticket.new
  end

  def import_student_csv
    event = Event.find(params[:ticket][:event_id])
    Tickets::Builders.call({ event: event, csv_path: params["ticket"]["file"] })

    redirect_to :action => :index, :notice => t("active_admin.notice.ticket.select_student_csv")
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      redirect_to manager_tickets_path(@ticket)
    else
      render :new
    end
  end

  private

  def set_ticket
    @ticket = Ticket.joins(:event, :student)
                    .where(events: { slug: params["slug_event"] }, students: { phone: params["phone"] }).take

    #@ticket = Ticket.find_by(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:event_id, :student_id, :svg, :png)
  end

  def set_event_options
    @event_options = Event.all.map { |e| [e.name, e.id] }
  end
end
