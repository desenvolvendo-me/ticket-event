if Rails.env.development?
  AdminUser.create!(email: 'admin@ticketevent.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')
  User.create!(email: 'marcodotcastro@gmail.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')

  template_ticket = TemplateTicket.create(name: 'Preto e Branco', description: "Ingresso na vertical com as cores preto e branco que permite alterar DATA_EVENTO, NOME, FOTO e NUMERO", version: "1")
  template_ticket.svg.attach(io: File.open(Rails.root.join('spec/support', 'ticket-2.svg')), filename: 'ticket-2.svg')

  event = Event.create(name: 'Bootcamp Imersão 1ª Vaga', launch: 1, description: "Aprenda a conquistar sua 1ª vaga na programação mesmo sem nenhuma experiência", date: (Date.today + 20.hours + 30.minutes) + 21.days)
  event.template.attach(io: File.open(Rails.root.join('spec/support', 'ticket.svg')), filename: 'ticket.svg')

  Tickets::Builders.call(event: event, csv_path: Rails.root.join('spec/support', "leads_export.csv"))

  # Checkin
  Ticket.first.update(checkin: true)

  # Create Certificate and attach file
  certificate = Certificate.create(student_id: Student.first.id, event_id: Event.first.id)
  certificate.certificate_file.attach(io: File.open(Rails.root.join('spec/support', 'avatar.png')), filename: 'avatar.png')
end

