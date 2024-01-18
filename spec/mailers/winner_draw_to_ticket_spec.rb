require "rails_helper"

RSpec.describe WinnerDrawToTicketMailer, type: :mailer do
  describe "winner_draw" do
    let(:mail) { WinnerDrawToTicketMailer.send_winner_draw }

    it "renders the headers" do
      expect(mail.subject).to eq("Winner draw")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
