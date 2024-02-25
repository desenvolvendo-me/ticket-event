# manager/events_controller.rb
class Manager::EventsController < ApplicationController
  before_action :get_event, only: %i[ show new create edit update destroy]

  def index
    @events = Event.all.order(created_at: :asc)
  end

  def search_events
    @search_query = params[:query]
    @search_by = params[:search_by] || 'name'

    search_fields = {
      'name' => 'name',
      'launch' => 'launch',
      'description' => 'description',
      'date' => 'date'
    }

    search_field = search_fields[@search_by]
    unless search_field
      flash[:error] = "Invalid search criteria"
      redirect_to manager_events_path and return
    end

    if search_field == 'launch' # Se o campo de pesquisa for 'launch'
      # Converta o query para inteiro
      @events = Event.where("#{search_field} = ?", @search_query.to_i)
    elsif
      search_field == 'date'
      # Convertendo a data de entrada para o formato de data esperado pelo PostgreSQL
      input_date = Date.strptime(@search_query, "%d/%m/%Y")

      # Calculando o intervalo de 24 horas para a data de pesquisa
      start_of_day = input_date.beginning_of_day
      end_of_day = input_date.end_of_day

      # Comparando se a data está dentro do intervalo de 24 horas
      @events = Event.where("#{search_field}::timestamp >= ? AND #{search_field}::timestamp <= ?", start_of_day, end_of_day)
    else
      formatted_query = "%#{@search_query}%"
      @events = Event.where("#{search_field} LIKE ?", formatted_query)
    end

    render 'index'
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.includes(:prize_draw).friendly.find(params[:id])
  end

  def edit; end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to manager_event_url(@event)
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to manager_event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    if @event.destroy
      redirect_to manager_events_path
    end
  end

  private

  def get_event
    @event = Event.find_by(slug: params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date, :launch, :community_link, :purchase_link, :purchase_date, :image)
  end
end
