class Manager::TicketsController < ApplicationController
  before_action :set_event_options, only: [:select_student_csv, :show]

  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def select_student_csv
    @ticket = Ticket.new
  end

  def import_student_csv
    event = Event.find(ticket_params[:event_id])
    Tickets::Builders.call({ event: event, csv_path: ticket_params["file"] })

    redirect_to action: :index
  end

  private

  def ticket_params
    params.require(:ticket).permit(:event_id, :file)
  end

  def set_event_options
    @event_options = Event.all.map { |e| [e.name, e.id] }
  end
end
