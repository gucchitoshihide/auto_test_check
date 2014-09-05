require "rails_helper"

RSpec.describe Announce, :type => :mailer do
  describe "resend_password" do
    let(:mail) { Announce.resend_password }

    it "renders the headers" do
      expect(mail.subject).to eq("Resend password")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
