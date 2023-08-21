class ApplicationController < ActionController::Base
  include ActiveStorage::SetCurrent
  before_action :authenticate_user!
end
