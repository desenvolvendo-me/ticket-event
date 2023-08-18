if Rails.env.development?
  AdminUser.create!(email: 'admin@ticketevent.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')
  user = User.create!(email: 'marcodotcastro@gmail.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')

  image_path = Rails.root.join('spec/support', 'ticket.svg')

  event1 = Event.create(description: 'Bootcamp Imersão 1ª Vaga', info: 'No dia 11/06 às 8h')
  event2 = Event.create(description: 'Bootcamp Programação com as IAs', info: 'No dia 07/08 às 8h')

  event1.template.attach(io: File.open(image_path), filename: 'ticket.svg')
  event2.template.attach(io: File.open(image_path), filename: 'ticket.svg')
end

