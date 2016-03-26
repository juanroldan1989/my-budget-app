require "rails_helper"

RSpec.describe Deal, "validations" do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:deal_type) }
end

RSpec.describe Deal, ".by_date" do
  it "returns deals: newers to olders" do
    oldest_deal = create(:deal, title: "Oldest deal")
    middle_deal = create(:deal, title: "Middle deal")
    newest_deal = create(:deal, title: "Newest deal")

    expect(Deal.by_date).to eq [newest_deal, middle_deal, oldest_deal]
  end
end

RSpec.describe Deal, ".by_price" do
  it "returns deals: from lowest price to highest price" do
    highest_price_deal = create(:deal, title: "Deal 10", price: 10)
    middle_price_deal  = create(:deal, title: "Deal 5",  price: 5)
    lowest_price_deal  = create(:deal, title: "Deal 1",  price: 1)

    expect(Deal.by_price).to eq [lowest_price_deal, middle_price_deal, highest_price_deal]
  end
end

RSpec.describe Deal, ".by_price_higher_than" do
  it "returns deals: with price higher or equal than X" do
    x = 5

    deal_1 = create(:deal, title: "Deal 10", price: 10)
    deal_2 = create(:deal, title: "Deal 5",  price: 5)
    deal_3 = create(:deal, title: "Deal 1",  price: 1)

    expect(Deal.by_price_higher_than(x)).to eq [deal_1,deal_2]
  end
end

RSpec.describe Deal, ".by_price_lower_than" do
  it "returns deals: with price lower or equal than X" do
    x = 5

    deal_1 = create(:deal, title: "Deal 10", price: 10)
    deal_2 = create(:deal, title: "Deal 5",  price: 5)
    deal_3 = create(:deal, title: "Deal 1",  price: 1)

    expect(Deal.by_price_lower_than(x)).to eq [deal_2, deal_3]
  end
end

RSpec.describe Deal, ".by_type" do
  it "returns deals: filtered by type ('single')" do
    deal_1 = create(:deal, title: "Deal 10", deal_type: "single")
    deal_2 = create(:deal, title: "Deal 5",  deal_type: "combined")
    deal_3 = create(:deal, title: "Deal 1",  deal_type: "single")

    expect(Deal.by_type("single")).to eq [deal_3, deal_1]
  end
end

RSpec.describe Deal, ".by_type" do
  it "returns deals: filtered by type ('combined')" do
    deal_1 = create(:deal, title: "Deal 10", deal_type: "single")
    deal_2 = create(:deal, title: "Deal 5",  deal_type: "combined")
    deal_3 = create(:deal, title: "Deal 1",  deal_type: "single")

    expect(Deal.by_type("combined")).to eq [deal_2]
  end
end
