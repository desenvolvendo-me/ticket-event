class RegistrationsController < Devise::RegistrationsController
  def new
    build_resource({})
    resource.build_student
    respond_with self.resource
  end
end