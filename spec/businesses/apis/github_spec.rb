require 'rails_helper'

RSpec.describe Apis::Github do

  #FIXME: Problema com github action
  xit 'get image' do
    student = create(:student, profile_social: "@marcodotcastro")
    github = Apis::Github.call(student: student)
    expect(github).to include("https://avatars.githubusercontent.com")
  end
end
