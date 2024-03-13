require 'rails_helper'

RSpec.describe Events::HappeningNow, type: :business_application do
  describe "#call" do
    context "when is_visible_during_event is true" do
      let(:event) { create(:event, is_visible_during_event: true) } # assuming you have a factory for Event model

      it "returns true when event is happening now" do
        allow(Time).to receive(:current).and_return(event.date) # set current time to event start time
        expect(described_class.new(event).call).to eq(true)
      end

      it "returns false when event is not happening now" do
        allow(Time).to receive(:current).and_return(event.date - 2.hours) # set current time before event start time
        expect(described_class.new(event).call).to eq(false)
      end
    end

    context "when is_visible_during_event is false" do
      let(:event) { create(:event, is_visible_during_event: false) }

      it "returns true" do
        expect(described_class.new(event).call).to eq(true)
      end
    end
  end
end
