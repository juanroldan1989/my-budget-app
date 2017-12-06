require "rails_helper"

RSpec.describe Deal do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:deal_type) }
  end

  describe ".by_date" do
    it "returns deals: newers to olders" do
      oldest_deal = create(:deal, title: "Oldest deal")
      middle_deal = create(:deal, title: "Middle deal")
      newest_deal = create(:deal, title: "Newest deal")

      expect(Deal.by_date).to eq [newest_deal, middle_deal, oldest_deal]
    end
  end

  describe ".by_price" do
    it "returns deals: from lowest price to highest price" do
      highest_price_deal = create(:deal, title: "Deal 10", price: 10)
      middle_price_deal  = create(:deal, title: "Deal 5",  price: 5)
      lowest_price_deal  = create(:deal, title: "Deal 1",  price: 1)

      expect(Deal.by_price).to eq [highest_price_deal, middle_price_deal, lowest_price_deal]
    end
  end

  describe ".by_price_higher_than" do
    it "returns deals: with price higher or equal than X" do
      x = 5

      deal_1 = create(:deal, title: "Deal 10", price: 10)
      deal_2 = create(:deal, title: "Deal 5",  price: 5)
      deal_3 = create(:deal, title: "Deal 1",  price: 1)

      expect(Deal.by_price_higher_than(x)).to eq [deal_1,deal_2]
      expect(Deal.by_price_higher_than(x)).not_to include(deal_3)
    end
  end

  describe ".by_price_lower_than" do
    it "returns deals: with price lower or equal than X" do
      x = 5

      deal_1 = create(:deal, title: "Deal 10", price: 10)
      deal_2 = create(:deal, title: "Deal 5",  price: 5)
      deal_3 = create(:deal, title: "Deal 1",  price: 1)

      expect(Deal.by_price_lower_than(x)).to eq [deal_2, deal_3]
      expect(Deal.by_price_lower_than(x)).not_to include deal_1
    end
  end

  describe ".by_type" do
    describe "returns deals filtered by type"do
      it "returns 'single' deals" do
        deal_1 = create(:deal, title: "Deal 10", deal_type: "single")
        deal_2 = create(:deal, title: "Deal 5",  deal_type: "combined")
        deal_3 = create(:deal, title: "Deal 1",  deal_type: "single")

        expect(Deal.by_type("single")).to eq [deal_3, deal_1]
        expect(Deal.by_type("single")).not_to include deal_2
      end

      it "returns 'combined' deals" do
        deal_1 = create(:deal, title: "Deal 10", deal_type: "single")
        deal_2 = create(:deal, title: "Deal 5",  deal_type: "combined")
        deal_3 = create(:deal, title: "Deal 1",  deal_type: "single")

        expect(Deal.by_type("combined")).to eq [deal_2]
        expect(Deal.by_type("combined")).not_to include [deal_1, deal_3]
      end
    end
  end

  describe "#is_combined?" do
    describe "defines if a deal is combined or not" do
      it "returns 'true' when deal is 'combined'" do
        combined_deal = create(:deal, deal_type: "combined")

        expect(combined_deal.is_combined?).to eq true
      end

      it "returns 'false' when deal is 'simple'" do
        single_deal = create(:deal, deal_type: "single")

        expect(single_deal.is_combined?).to eq false
      end
    end
  end

  describe "#normalize_friendly_id" do
    describe "it restricts Deal's slug to 40 characters tops" do
      it "applies for deals with titles longer than 40 characters" do
        deal = create(:deal, title: "title with really really more than 40 characters")

        expect(deal.slug.length).to eq 40
      end

      it "does not apply for deals with titles shorter than 40 characters" do
        deal = create(:deal, title: "title with less than 40 characters")

        expect(deal.slug.length).to eq 34
      end
    end
  end

  describe "before_save method: set_keywords" do
    it "sets 'keywords' field based on the 'slug' field when creating a 'single' deal" do
      deal = create(:deal, title: "This is a nice deal", deal_type: "single")

      expect(deal.keywords).to eq ["this", "is", "a", "nice", "deal"]
    end
  end

  # PgSearch scopes #
  describe ".title_search" do
    it "returns deals with titles matching ALL words searched by ('AND' behavior)" do
      deal_1 = create(:deal, title: "Amazing deal with adventure")
      deal_2 = create(:deal, title: "Amazing deal with adventure and fun")
      deal_3 = create(:deal, title: "Amazing deal with adventure and fun and races")

      expect(Deal.title_search("adventure")).to                   eq [deal_1, deal_2, deal_3]
      expect(Deal.title_search("adventure and fun")).to           eq [deal_2, deal_3]
      expect(Deal.title_search("adventure and fun and races")).to eq [deal_3]
    end
  end

  describe ".keywords_search" do
    it "returns deals with keywords matching ANY words searched by ('OR' behavior)" do
      deal_1 = create(:deal, title: "Perfect deal with adventure", deal_type: "single")
      deal_2 = create(:deal, title: "Best deal with adventure and fun", deal_type: "single")
      deal_3 = create(:deal, title: "Amazing deal with adventure and fun and races", deal_type: "single")

      expect(Deal.keywords_search(["perfect"]).to_a).to                    eq [deal_1]
      expect(Deal.keywords_search(["perfect", "best"]).to_a).to            eq [deal_1, deal_2]
      expect(Deal.keywords_search(["perfect", "fun"]).to_a).to             eq [deal_1, deal_2, deal_3]
      expect(Deal.keywords_search(["perfect", "best", "amazing"]).to_a).to eq [deal_1, deal_2, deal_3]
    end
  end
  # PgSearch scopes #
end
