require "rails_helper"

RSpec.describe PrizeDraws::Generator do
  let(:event) { create(:event) }
  let(:students) do
    Array.new(3) do
      create(:student, name: FFaker::Name.name)
    end
  end
  let(:unregistered_student) { create(:student) }
  let(:draw) { described_class.call(event) }

  before do
    students.each do |student|
      create(:ticket, student: student, event: event)
    end
  end

  context 'when the draw is executed' do
    it "ensures winner is registered for the event" do
      expect(event.tickets.map(&:student)).to include(draw.winner)
    end
  end
end