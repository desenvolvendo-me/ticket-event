if Rails.env.development?
  AdminUser.create!(email: 'admin@ticketevent.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')
  User.create!(email: 'marcodotcastro@gmail.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')
  ManagerUser.create!(email: 'infoprodutor@ticketevent.com', password: 'abc12345abc', password_confirmation: 'abc12345abc', login: "PhilipeX", full_name: "Philipe Rodrigues")
  student_user = StudentUser.create!(email: 'student@ticketevent.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')
  Student.create(email: 'student@ticketevent.com', name: 'John Doe', phone: '123-456-7890', profile_social: 'example_github', type_social: 'github', student_user: student_user)

  template_ticket = TemplateTicket.create(name: 'Preto e Branco', description: "Ingresso na vertical com as cores preto e branco que permite alterar DATA_EVENTO, NOME, FOTO e NUMERO", version: "1")
  template_ticket.svg.attach(io: File.open(Rails.root.join('spec/support', 'ticket-2.svg')), filename: 'ticket-2.svg')

  event = Event.create(name: 'Bootcamp Imersão 1ª Vaga', launch: 1, description: "Aprenda a conquistar sua 1ª vaga na programação mesmo sem nenhuma experiência", date: (Date.today + 20.hours + 30.minutes) + 21.days, community_link: 'https://discord.gg/Tq3KQZTd', purchase_link: 'https://pagar.me/blog/checkout-de-pagamento/', purchase_date: Time.zone.now + 5.hours)
  event.template.attach(io: File.open(Rails.root.join('spec/support', 'ticket.svg')), filename: 'ticket.svg')
  event.certificate_template.attach(io: File.open(Rails.root.join('spec/support', 'certificate_template.svg')), filename: 'certificate_template.svg')

  Tickets::Builders.call(event: event, csv_path: Rails.root.join('spec/support', "leads_export.csv"))

  # Checkin
  Ticket.first.update(checkin: true)

  # Create Certificate and attach file
  certificate = Certificate.create(student_id: Student.first.id, event_id: Event.first.id)
  Certificates::Builder.call(certificate: certificate)

  # Certificate Template
  certificate_template = CertificateTemplate.create(name: "Template 01", description: "Certificado tamanho 297 x 210 mm com moldura azul", version: "1")
  certificate_template.svg.attach(io: File.open(Rails.root.join('spec/support', 'certificate_template.svg')), filename: 'certificate_template.svg')

  # Load thumbnail
  thumbnail_path = Rails.root.join('app', 'assets', 'images', 'video-play-new.jpg')
  thumbnail = Rack::Test::UploadedFile.new(thumbnail_path, 'image/jpeg')

  #Create Lessons
  lesson_rails_admin = Lesson.create(link: 'https://youtu.be/NJYtzznKrg0?si=3jihxtTuENaU98d4',
                title: 'Rails Admin Interfaces with ActiveAdmin',
                description: 'for Pro episodes and more!',
                launch_datetime: Time.zone.now,
                thumbnail: thumbnail,
                event: event)
  lesson_railscasts = Lesson.create(link: 'https://youtu.be/_XUdbOFrDRQ?si=XO90bMeEXed_JoZF',
                title: 'Ruby on Rails - Railscasts #284 Active Admin',
                description: 'Active Admin allows you to quickly build an admin interface with just a few commands.',
                launch_datetime: Time.zone.now,
                thumbnail: thumbnail,
                event: event)
  lesson_rails_fullcourse = Lesson.create(link: 'https://youtu.be/fmyvWz5TUWg?si=hVjWIKZShmZBPrRs',
                title: 'Learn Ruby on Rails - Full Course',
                description: 'Learn Ruby on Rails in this full course for beginners. Ruby on Rails is a server-side web application framework used for creating full stack web apps.',
                launch_datetime: Time.zone.now + 3.hours,
                thumbnail: thumbnail,
                event: event)
  lesson_openvagas = Lesson.create(link: 'https://youtu.be/dWVo2Ma6ZpU?si=uZsta-amoNZIaaKi',
                title: 'Open Vagas - Aula 1 - Criando um sistema de vagas no Ruby on Rails',
                description: 'Este é o primeiro vídeo da serie criando um sistema de vagas.',
                launch_datetime: Time.zone.now + 5.hours,
                thumbnail: thumbnail,
                event: event)
  lesson_comecando_ruby = Lesson.create(link: 'https://www.youtube.com/live/3qgcPXnmbA8?si=UF-k8re3bAAGsvfF',
                title: 'Começando com o Ruby on Rails',
                description: 'Talk sobre como iniciar no mundo Ruby on Rails',
                launch_datetime: Time.zone.now + 72.hours,
                thumbnail: thumbnail,
                event: event)
  # Create quizzes
  quiz1 = Quiz.create(title: 'Quiz da aula sobre o active admin', lesson: lesson_rails_admin)
  quiz2 = Quiz.create(title: 'Quiz do episodio de railscasts', lesson: lesson_railscasts)
  quiz3 = Quiz.create(title: 'Quiz do curso rails fullcourse', lesson: lesson_rails_fullcourse)
  quiz4 = Quiz.create(title: 'Quiz da aula sobre a aplicação openvagas', lesson: lesson_openvagas)
  quiz5 = Quiz.create(title: 'Quiz da aula sobre começar com ruby on rails', lesson: lesson_comecando_ruby)

  QuizQuestion.create(
    description: 'Responda qual das questoes abaixo é falsa sobre active admin',
    answer1: 'Interface de Administração Rápida para Ruby on Rails',
    answer2: 'Personalização de Painéis de Administração',
    answer3: 'O Active Admin é um produto comercial pago',
    answer4: 'Integração com Autenticação e Autorização',
    correct_answer: 3,
    quiz: quiz1
  )
  QuizQuestion.create(
    description: 'Qual é a principal característica do Active Admin?',
    answer1: 'Criação automática de código Ruby para a aplicação.',
    answer2: 'Geração automática de designs de interface de usuário.',
    answer3: 'Interface de administração personalizável para Ruby on Rails.',
    answer4: 'Integração perfeita com sistemas de pagamento.',
    correct_answer: 3,
    quiz: quiz1
  )
  QuizQuestion.create(
    description: 'Qual é o comando Rails usado para criar um novo controlador?',
    answer1: 'rails new controller NomeDoController',
    answer2: 'rails generate controller NomeDoController',
    answer3: 'rails create controller NomeDoController',
    answer4: 'rails controller create NomeDoController',
    correct_answer: 2,
    quiz: quiz2
  )
  QuizQuestion.create(
    description: 'O que é uma migração no contexto do Ruby on Rails?',
    answer1: 'Uma atualização para a linguagem Ruby.',
    answer2: 'Uma maneira de mover arquivos entre pastas no Rails.',
    answer3: 'Uma alteração no banco de dados da aplicação.',
    answer4: 'Um método para criar novos modelos em Rails.',
    correct_answer: 3,
    quiz: quiz2
  )
  QuizQuestion.create(
    description: 'Qual é o propósito principal do arquivo routes.rb em uma aplicação Ruby on Rails?',
    answer1: 'Definir o estilo de layout da aplicação.',
    answer2: 'Configurar as rotas de URL para os controladores e ações.',
    answer3: 'Definir a estrutura de banco de dados da aplicação.',
    answer4: 'Configurar os estilos de CSS da aplicação.',
    correct_answer: 2,
    quiz: quiz2
  )
  QuizQuestion.create(
    description: 'O que é um "scaffold" em Ruby on Rails?',
    answer1: 'Um tipo de estrutura de madeira usada na construção de casas.',
    answer2: 'Um comando usado para criar automaticamente um conjunto completo de recursos em Rails.',
    answer3: 'Um modelo de design de interface de usuário para aplicativos Rails.',
    answer4: 'Uma gema para geração de documentação em Rails.',
    correct_answer: 2,
    quiz: quiz2
  )

  # PrizeDraw
  PrizeDraws::Generator.call(Event.first)

  # Student registration from a CSV
  Students::BatchCreator.call(csv_path: Rails.root.join('spec/support', "leads_export.csv"))
end
