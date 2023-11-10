require 'rails_helper'
require 'spec_helper'

RSpec.describe Manager::LessonsController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new lesson" do
      event = create(:event)
      expect {
        post :create, params: { lesson: { link: "https://www.youtube.com/watch?v=pNfZwWqggQw", title: "Example Title", description: "Example Description", event_id: event.id } }
      }.to change(Lesson, :count).by(1)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      manager_user = create(:manager_user)
      sign_in manager_user
      lesson = create(:lesson, manager_user_id: manager_user.id)
      get :show, params: { id: lesson.id }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      manager_user = create(:manager_user)
      sign_in manager_user
      lesson = create(:lesson, manager_user_id: manager_user.id)
      get :edit, params: { id: lesson.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    it "updates a lesson with a new title" do
      manager_user = create(:manager_user)
      sign_in manager_user
      lesson = create(:lesson, manager_user_id: manager_user.id)
      patch :update, params: { id: lesson.id, lesson: { title: "Updated Title" } }
      lesson.reload
      expect(lesson.title).to eq("Updated Title")
      expect(response).to redirect_to(manager_lesson_path(lesson))
    end
  end

  describe "DELETE #destroy" do
    it "destroys a lesson" do
      manager_user = create(:manager_user)
      sign_in manager_user
      lesson = create(:lesson, manager_user_id: manager_user.id)
      expect {
        delete :destroy, params: { id: lesson.id }
      }.to change(Lesson, :count).by(-1)

      expect(response).to redirect_to(manager_lessons_path)
    end
  end
end
