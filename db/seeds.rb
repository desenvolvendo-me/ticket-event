if Rails.env.development?
  AdminUser.create!(email: 'admin@ticketevent.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')
  User.create!(email: 'marcodotcastro@gmail.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')

  image_path = Rails.root.join('spec/support', 'ticket.svg')

  template_ticket = TemplateTicket.create(name: 'Preto e Branco', description: "Ingresso na vertical com as cores preto e branco que permite alterar DATA_EVENTO, NOME, FOTO e NUMERO", version: "1")
  template_ticket.svg.attach(io: File.open(image_path), filename: 'ticket.svg')

  event = Event.create(name: 'Bootcamp Imersão 1ª Vaga', launch: 1, description: "Aprenda a conquistar sua 1ª vaga na programação mesmo sem nenhuma experiência", date: (Date.today + 20.hours + 30.minutes) + 21.days)
  event.template.attach(io: File.open(image_path), filename: 'ticket.svg')

  Tickets::Builders.call(event: event, csv_path: Rails.root.join('spec/support', "leads_export.csv"))

  # Create Lessons
  Lesson.create(link: 'https://youtu.be/NJYtzznKrg0?si=3jihxtTuENaU98d4', event: event)
  Lesson.create(link: 'https://youtu.be/_XUdbOFrDRQ?si=XO90bMeEXed_JoZF', event: event)
  Lesson.create(link: 'https://youtu.be/NJYtzznKrg0?si=3jihxtTuENaU98d4', event: event)
  Lesson.create(link: 'https://youtu.be/_XUdbOFrDRQ?si=XO90bMeEXed_JoZF', event: event)
  Lesson.create(link: 'https://youtu.be/NJYtzznKrg0?si=3jihxtTuENaU98d4', event: event)
end

