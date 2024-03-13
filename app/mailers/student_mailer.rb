class StudentMailer < ApplicationMailer
   def welcome_email(student)
    mail(to: student.email, subject: 'Bem-vindo à nossa plataforma')
  end
end
