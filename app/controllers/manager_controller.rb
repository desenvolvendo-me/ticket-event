class ManagerController < ApplicationController
  before_action :authenticate_manager_user!
end

