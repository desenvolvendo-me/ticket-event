class External::CertificatesController < ExternalController
  before_action :get_certificate, only: %i[certificate form share]

  def certificate; end

  def share
    @share_url = event_certificate_url(@certificate.event.slug, @certificate.student.phone)
    render "certificate"
  end

  def search
    @slug_event = params[:slug_event]
  end

  def form
    return redirect_to event_certificate_share_path(@certificate.event.slug, @certificate.student.phone) if @certificate

    redirect_to search_certificate_path(params["slug_event"]), notice: t('notice.certificate_does_not_exist')
  end

  def verify
    @certificate = Certificate.find_by(verification_link: params[:verification_link])

    if @certificate
      render :verify
    else
      render :not_found
    end
  end



  private

  def get_certificate
    @certificate = Certificate.joins(:event, :student)
                    .where(events: { slug: params["slug_event"] }, students: { phone: params["phone"] }).take
  end
end
