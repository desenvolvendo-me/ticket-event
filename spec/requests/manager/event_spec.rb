require 'rails_helper'

RSpec.describe "Manager::Events", type: :request do

  describe "POST /manager/events/:id/run_prize_draw" do
    let!(:event) { create(:event) }
    let!(:student) { create(:student) }
    let!(:ticket) { create(:ticket, student: student, event: event, student_score: 70) }

    it "run prize draw" do
      expect { post run_prize_draw_manager_event_path(event) }
        .to change(PrizeDraw, :count).by(1)
    end
  end
end
