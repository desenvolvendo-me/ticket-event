require 'rails_helper'

RSpec.describe Apis::Instagram do

  #FIXME: Não funciona se está logado, é necessário usar a API do Facebook
  xit 'get image' do
    student = create(:student, profile_social: "@marcodotcastro")
    instagram = Apis::Instagram.call(student: student)
    expect(instagram).to include("https://instagram.fjjg3-1.fna.fbcdn.net")
  end
end
