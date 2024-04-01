class CertificateMailer < ApplicationMailer
  def certificate_generated_email(student, certificate)
    @student = student
    @certificate = certificate
    @certificate_url = certificate.absolute_url

    svg_filename = "certificate-#{certificate.id}.svg"
    svg_content = certificate.svg.download
    attachments[svg_filename] = svg_content

    mail(to: @student.email, subject: 'Seu certificado está pronto!')
  end
end
