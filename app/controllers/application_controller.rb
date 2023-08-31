class ApplicationController < ActionController::Base
  include ActiveStorage::SetCurrent
  # TODO: Devise já configurado para o frontend,
  # mais ainda não precisa ser usado
  # before_action :authenticate_user!
end
