class CertificatesController < ExternalController
  before_action :get_certificate, only: %i[certificate form]

  def certificate
  end

  def search
    @slug_event = params[:slug_event]
  end

  def form
    return redirect_to event_certificate_path(@certificate.event.slug, @certificate.student.phone) if @certificate

    redirect_to search_certificate_path(params["slug_event"]), notice: t('notice.certificate_does_not_exist')
  end

  private

  def get_certificate
    @certificate = Certificate.joins(:event, :student)
                    .where(events: { slug: params["slug_event"] }, students: { phone: params["phone"] }).take
  end
end
