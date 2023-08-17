if Rails.env.development?
  AdminUser.create!(email: 'admin@ticketevent.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')
  user = User.create!(email: 'marcodotcastro@gmail.com', password: 'abc12345abc', password_confirmation: 'abc12345abc')
end

