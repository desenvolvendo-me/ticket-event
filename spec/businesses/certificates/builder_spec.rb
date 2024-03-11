require 'rails_helper'

RSpec.describe Certificates::Builder do
  let(:certificate) { create(:certificate) }
  let(:certificate_builder) { Certificates::Builder.call(certificate: certificate) }
  let(:student_name) { "#{certificate.student.name.split.first} #{certificate.student.name.split.last}" }
  let(:event_start_date) { I18n.l(certificate.event.date.to_date, format: :default) }
  let(:event_end_date) { I18n.l((certificate.event.date + 6.days).to_date, format: :default) }
  let(:issuance_date) { I18n.l(certificate.created_at.to_date, format: :default) }
  let(:event_duration) {certificate.event.duration.to_s}

  it "change certificate template" do
    certificate_builder

    expect(certificate.svg).to be_attached
    expect(certificate.png).to be_attached
    expect(certificate.svg.download).to include(student_name)
    expect(certificate.svg.download).to include(event_start_date)
    expect(certificate.svg.download).to include(event_end_date)
    expect(certificate.svg.download).to include(issuance_date)
    expect(certificate.svg.download).to include(event_duration)
  end
end