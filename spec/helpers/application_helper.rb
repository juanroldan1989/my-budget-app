require "rails_helper"

RSpec.describe ApplicationHelper do
  # 'helper' is an instance of ActionView::Base configured with the
  # EventsHelper and all of Rails' built-in helpers

  describe "#deal_price_text" do
    describe "displays Deal's price with the right format" do
      it "when deal has a price set" do
        deal = create(:deal, price: 10)
        expect(helper.deal_price_text(deal)).to eq "<b>Single deal for $10.0</b>"
      end

      it "when deal doesn't have a price set" do
        deal = create(:deal, price: 0, price_text: ["Adults only"])
        expect(helper.deal_price_text(deal)).to eq "<b>Adults only</b>"
      end
    end
  end

end
