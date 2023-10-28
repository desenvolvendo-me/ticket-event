require 'rails_helper'

RSpec.describe Students::Creator, type: :service do
  describe '#call' do
    let(:row) do
      {
        email: FFaker::Internet.email,
        phone: FFaker::PhoneNumber.phone_number,
        fullname: FFaker::Name.name,
        profile_social: FFaker::Internet.http_url,
        type_social: FFaker::Lorem.word
      }
    end

    let(:student) { Student.last }

    it "creates a new student with correct attributes" do
      expect { described_class.new(row).call }.to change(Student, :count).by(1)
      expect(student.email).to eq(row["email"])
      expect(student.phone).to eq(row["phone"])
      expect(student.name).to eq(row["fullname"])
      expect(student.profile_social).to eq(row["profile_social"])
      expect(student.type_social).to eq(row["type_social"])
    end
  end
end