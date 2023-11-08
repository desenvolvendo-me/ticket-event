class ApplicationController < ActionController::Base
  include ActiveStorage::SetCurrent
  set_current_tenant_through_filter
  before_action :find_current_tenant

  def find_current_tenant
    set_current_tenant(current_manager_user)
  end
end
