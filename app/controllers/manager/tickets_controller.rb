class Manager::TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]
  before_action :set_event_options, only: [:select_student_csv, :show]
  before_action :set_ticket, only: [:send_email, :show]


  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params_individually)

    if @ticket.save
      redirect_to manager_ticket_url(@ticket)
    else
      render :new
    end
  end

  def update
    if @ticket.update(ticket_params_individually)
      redirect_to manager_ticket_url(@ticket)
    else
      render :edit
    end
  end

  def destroy
    if @ticket.destroy
      redirect_to manager_tickets_path
    end
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

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params_individually
    params.require(:ticket).permit(:event_id, :student_id, :send_email_at, :number,
                                   :checkin, :student_score, :student_answers)
  end

  def set_event_options
    @event_options = Event.all.map { |e| [e.name, e.id] }
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
