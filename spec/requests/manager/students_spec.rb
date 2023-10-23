require 'rails_helper'

RSpec.describe "Manager::Students", type: :request do
  let!(:student1) { create(:student, name: "Student1") }
  let!(:student2) { create(:student, name: "Student2") }

  let(:valid_attributes) {
    {
      email: FFaker::Internet.email,
      name: FFaker::Name.name,
      phone: FFaker::PhoneNumber.phone_number,
      profile_social: FFaker::Name.first_name.downcase + FFaker::Name.last_name.downcase,
      type_social: FFaker::Lorem.word
    }
  }

  describe "GET /manager/students" do
    it "displays the students" do
      get manager_students_path

      expect(response).to have_http_status :ok
      expect(response.body).to include('Student1')
      expect(response.body).to include('Student2')
    end
  end

  describe "GET /manager/students/:id" do
    it "returns successful status and attributes" do
      get manager_student_path(student1)

      expect(response).to have_http_status :ok
      expect(response.body).to include("Student1")
    end
  end

  describe "POST /manager/students/create" do
    it "create a new Student" do
      expect { post manager_students_path, params: { student: valid_attributes }
      }.to change(Student, :count).by(1)
    end
  end

  describe "PATCH /manager/students/:id" do
    it "update a student" do
      patch manager_student_path(student1), params: { student: valid_attributes }

      expect(response).to redirect_to(manager_student_path(student1))
      student1.reload
      expect(student1.name).to eq(valid_attributes[:name])
      expect(student1.email).to eq(valid_attributes[:email])
      expect(student1.phone).to eq(valid_attributes[:phone])
      expect(student1.profile_social).to eq(valid_attributes[:profile_social])
      expect(student1.type_social).to eq(valid_attributes[:type_social])
    end
  end

  describe "DELETE /manager/students/:id" do
    it "delete a student" do

      expect { delete manager_student_path(student2) }.to change(Student, :count).by(-1)
      expect(response).to redirect_to(manager_students_path)
    end
  end
end
