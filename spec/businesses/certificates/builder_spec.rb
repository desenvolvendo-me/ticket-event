require 'rails_helper'

RSpec.describe Certificates::Builder do
  let(:certificate) { create(:certificate) }
  let(:certificate_builder) { Certificates::Builder.call(certificate: certificate) }
  let(:student_name) { "#{certificate.student.name.split.first} #{certificate.student.name.split.last}" }

  it "change certificate template" do
    certificate_builder

    expect(certificate.svg).to be_attached
    expect(certificate.png).to be_attached
    expect(certificate.svg.download).to include(student_name)
  end
end