require 'rails_helper'

RSpec.describe Events::Validator do
  let(:event) { double("Event") }
  subject { described_class.new(event) }

  describe "#call" do
    context "when duration format is invalid" do
      before do
        allow(event).to receive(:duration).and_return("invalid")
        allow(event).to receive(:is_visible_after_time?).and_return(false)
        subject.call
      end

      it "adds an error message for duration" do
        expect(subject.errors).to include({ duration: "Obrigatório informar a duração do evento" })
      end
    end
  end
end
