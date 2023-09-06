if Rails.env.development?
  AdminUser.create!(email: 'admin@ticketevent.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')
  User.create!(email: 'marcodotcastro@gmail.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')

  template_ticket = TemplateTicket.create(name: 'Preto e Branco', description: "Ingresso na vertical com as cores preto e branco que permite alterar DATA_EVENTO, NOME, FOTO e NUMERO", version: "1")
  template_ticket.svg.attach(io: File.open(Rails.root.join('spec/support', 'ticket-2.svg')), filename: 'ticket-2.svg')

  event = Event.create(name: 'Bootcamp Imersão 1ª Vaga', launch: 1, description: "Aprenda a conquistar sua 1ª vaga na programação mesmo sem nenhuma experiência", date: (Date.today + 20.hours + 30.minutes) + 21.days)
  event.template.attach(io: File.open(Rails.root.join('spec/support', 'ticket.svg')), filename: 'ticket.svg')
  event.certificate_template.attach(io: File.open(Rails.root.join('spec/support', 'certificate_template.svg')), filename: 'certificate_template.svg')

  Tickets::Builders.call(event: event, csv_path: Rails.root.join('spec/support', "leads_export.csv"))

  # Checkin
  Ticket.first.update(checkin: true)

  # Create Certificate and attach file
  certificate = Certificate.create(student_id: Student.first.id, event_id: Event.first.id)
  Certificates::Builder.call(certificate: certificate)

  # Load thumbnail
  thumbnail_path = Rails.root.join('app', 'assets', 'images', 'video-play-new.jpg')
  thumbnail = Rack::Test::UploadedFile.new(thumbnail_path, 'image/jpeg')

  #Create Lessons
  lessons_data = [
    {
      link: 'https://youtu.be/NJYtzznKrg0?si=3jihxtTuENaU98d4',
      title: 'Rails Admin Interfaces with ActiveAdmin',
      description: 'for Pro episodes and more!',
      launch_datetime: Time.zone.now,
      thumbnail: thumbnail,
      event: event
    },
    {
      link: 'https://youtu.be/_XUdbOFrDRQ?si=XO90bMeEXed_JoZF',
      title: 'Ruby on Rails - Railscasts #284 Active Admin',
      description: 'Active Admin allows you to quickly build an admin interface with just a few commands.',
      launch_datetime: Time.zone.now + 1.hour,
      thumbnail: thumbnail,
      event: event
    },
    {
      link: 'https://youtu.be/fmyvWz5TUWg?si=hVjWIKZShmZBPrRs',
      title: 'Learn Ruby on Rails - Full Course',
      description: 'Learn Ruby on Rails in this full course for beginners. Ruby on Rails is a server-side web application framework used for creating full stack web apps.',
      launch_datetime: Time.zone.now + 3.hours,
      thumbnail: thumbnail,
      event: event
    },
    {
      link: 'https://youtu.be/dWVo2Ma6ZpU?si=uZsta-amoNZIaaKi',
      title: 'Open Vagas - Aula 1 - Criando um sistema de vagas no Ruby on Rails',
      description: 'Este é o primeiro vídeo da serie criando um sistema de vagas.',
      launch_datetime: Time.zone.now + 5.hours,
      thumbnail: thumbnail,
      event: event
    },
    {
      link: 'https://www.youtube.com/live/3qgcPXnmbA8?si=UF-k8re3bAAGsvfF',
      title: 'Começando com o Ruby on Rails',
      description: 'Talk sobre como iniciar no mundo Ruby on Rails',
      launch_datetime: Time.zone.now + 72.hours,
      thumbnail: thumbnail,
      event: event
    }
  ]
  lessons_data.each do |data|
    Lesson.create(data)
  end
end

