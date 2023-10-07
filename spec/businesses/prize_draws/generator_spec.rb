require "rails_helper"

RSpec.describe PrizeDraws::Generator do
  let(:event) { create(:event) }
  let(:students) do
    Array.new(5) do
      create(:student, name: FFaker::Name.name)
    end
  end
  let(:prize_draw) { described_class.call(event) }

  context 'when students achieve the required score' do
    it "the draw is carried out successfully" do

      high_score_students = students.sample(2)
      low_score_students = students - high_score_students

      high_score_students.each do |student|
        create(:ticket, student: student, event: event, student_score: rand(70..100))
      end

      low_score_students.each do |student|
        create(:ticket, student: student, event: event, student_score: rand(0..69))
      end

      expect(event.tickets).to include(prize_draw.ticket)
      expect(high_score_students).to include(prize_draw.ticket.student)
      expect(prize_draw.ticket.student_score).to be >= 70
    end
  end

  context 'when students have not yet reached the minimum score' do
    it "prize draw is not created" do

      students.each do |student|
        create(:ticket, student: student, event: event)
      end

      expect(prize_draw).to eq(nil)
    end
  end
end