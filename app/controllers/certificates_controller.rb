class CertificatesController < ApplicationController
  layout "external"
  before_action :get_certificate, only: %i[certificate form]

  def certificate
  end

  def search
    @slug_event = params[:slug_event]
  end

  def form
    if @certificate
      redirect_to event_certificate_path(@certificate.event.slug, @certificate.student.phone)
    else
      redirect_to search_certificate_path(params["slug_event"]), notice: t('notice.phone_not_registered_in_event')
    end
  end

  private

  def get_certificate
    @certificate = Certificate.joins(:event, :student)
                    .where(events: { slug: params["slug_event"] }, students: { phone: params["phone"] }).take
  end
end
