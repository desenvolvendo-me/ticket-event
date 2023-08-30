require 'rails_helper'

RSpec.describe "Admin::Lessons", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:admin_user) }
  let(:event) { create(:event) }
  let(:valid_attributes) { { link: 'https://youtu.be/NJYtzznKrg0?si=I-ehF7U8g_UhoHeK', event_id: event.id } }
  let(:invalid_attributes) { { link: '', event_id: event.id } }

  before do
    sign_in user
    sign_in admin, scope: :admin_user
  end

  describe "POST /admin/lessons" do
    context "with valid attributes" do
      it "creates a new lesson" do
        expect {
          post admin_lessons_path, params: { lesson: valid_attributes }
        }.to change(Lesson, :count).by(1)

        expect(response).to redirect_to(admin_lesson_path(Lesson.last))
      end
    end

    context "with invalid attributes" do
      it "does not create a new lesson" do
        expect {
          post admin_lessons_path, params: { lesson: invalid_attributes }
        }.not_to change(Lesson, :count)

        expect(response).to be_successful
      end
    end
  end
end
