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

    context "when duration format is valid" do
      before do
        allow(event).to receive(:duration).and_return(2)
        allow(event).to receive(:is_visible_after_time?).and_return(true)
        allow(event).to receive(:visible_after_time).and_return(nil)
        subject.call
      end

      it "does not add an error message for duration" do
        expect(subject.errors).not_to include({ duration: "Invalid duration format" })
      end
    end
  end
end
