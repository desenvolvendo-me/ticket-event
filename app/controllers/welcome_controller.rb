class WelcomeController < ApplicationController
  before_action :authenticate_manager_user!, except: [:index]
  def index
  end
end
