# spec/businesses/grades_draws/scoredraw_spec.rb

require 'rails_helper'

RSpec.describe GradesDraws::Scoredraw do
  let(:event) { create(:event) }
  let(:lesson) { create(:lesson) }
  let(:student_responses) { { '1' => 'answer3', '2' => 'answer1', '3' => 'answer2' } }
  let(:ticket) { create(:ticket) }

  subject(:scoredraw) { described_class.new(event, lesson, student_responses, ticket) }

  describe '#integrate' do
    context 'when student score is above passing score' do
      before { allow(ticket).to receive(:student_score).and_return(75) }

      it 'calculates quiz result and generates prize draw' do
        expect_any_instance_of(Quizzes::QuizResultCalculator).to receive(:calculate)
        expect_any_instance_of(PrizeDraws::Generator).to receive(:call)
        scoredraw.integrate
      end
    end

    context 'when student score is below passing score' do
      before { allow(ticket).to receive(:student_score).and_return(60) }

      it 'does not generate prize draw' do
        expect_any_instance_of(Quizzes::QuizResultCalculator).to receive(:calculate)
        expect_any_instance_of(PrizeDraws::Generator).not_to receive(:call)
        scoredraw.integrate
      end
    end
  end
end
