# manager/events_controller.rb
class Manager::EventsController < ApplicationController
  before_action :get_event, only: %i[ show new create edit update destroy]

  def index
    @events = Event.all.order(created_at: :asc)
  end

  def search_events
    @search_query = params[:query]
    @search_by = params[:search_by] || 'name' # Se nenhum critério for selecionado, o padrão é 'name'

    # Use um hash para mapear os critérios de pesquisa aos campos correspondentes no modelo Event
    search_fields = {
      'name' => 'name',
      'launch' => 'launch',
      'description' => 'description',
      'date' => 'date'
    }

    # Verifique se o critério de pesquisa selecionado é um dos campos permitidos
    search_field = search_fields[@search_by]
    unless search_field
      flash[:error] = "Invalid search criteria"
      redirect_to manager_events_path and return
    end

    # Use o critério de pesquisa selecionado para consultar o banco de dados
    @events = Event.where("#{search_field} LIKE ?", "%#{@search_query}%")

    # Aqui você pode ajustar a consulta conforme necessário, dependendo dos campos que deseja pesquisar
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
