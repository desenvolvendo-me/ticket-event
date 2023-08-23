if Rails.env.development?
  AdminUser.create!(email: 'admin@ticketevent.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')
  User.create!(email: 'marcodotcastro@gmail.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')

  image_path = Rails.root.join('spec/support', 'ticket.svg')

  event = Event.create(name: 'Bootcamp Imersão 1ª Vaga', launch: 1, description: "Aprenda a conquistar sua 1ª vaga na programação mesmo sem nenhuma experiência", date: (Date.today + 20.hours + 30.minutes) + 21.days)
  event.template.attach(io: File.open(image_path), filename: 'ticket.svg')

  Tickets::Builder.call(event: event, csv_path: Rails.root.join('spec/support', "leads_export.csv"))
end

