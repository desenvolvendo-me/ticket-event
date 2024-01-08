require "rails_helper"

RSpec.describe PrizeDraws::Generator do
  let(:event) {create(:event)}
  let!(:prize_draw) { create(:prize_draw, event: event)}

  context "The class is valid" do
    it 'its valid 'do
      expect(defined?(PrizeDraws::Generator)).to eq('constant')
    end
  end

  context 'when no student achieves the required score' do
    it 'returns nil' do
      students = create_list(:student, 5)

      students.each do |student|
        create(:ticket, student: student, event: event, student_score: rand(0..69))
      end
      prize_draw_result = described_class.new(event, prize_draw).call
      expect(prize_draw_result).to be_nil
    end
  end
end