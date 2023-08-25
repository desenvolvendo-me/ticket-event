require 'rails_helper'

RSpec.describe Apis::Instagram do

  it 'get image' do
    student = create(:student, username_instagram: "marcodotcastro")
    instagram = Apis::Instagram.call(student: student)
    expect(instagram).to eq("https://instagram.fjjg3-1.fna.fbcdn.net/v/t51.2885-19/173905431_359517825464979_3285762568743686046_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fjjg3-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=eBRnAjPLpIAAX8q0AvG&edm=AKEQFekBAAAA&ccb=7-5&oh=00_AfDT8eO3dw6DBsz4VQZritFWVA7RE5wN7_Oz60oW_2pQ9A&oe=64EE4032&_nc_sid=29ddf3")
  end
end
