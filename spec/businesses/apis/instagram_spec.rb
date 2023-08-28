require 'rails_helper'

RSpec.describe Apis::Instagram do

  it 'get image' do
    student = create(:student, profile_social: "@marcodotcastro")
    instagram = Apis::Instagram.call(student: student)
    expect(instagram).to include("https://instagram.fjjg3-1.fna.fbcdn.net")
  end
end
