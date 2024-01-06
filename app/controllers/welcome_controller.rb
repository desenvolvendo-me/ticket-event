class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    #Coment
  end
end
