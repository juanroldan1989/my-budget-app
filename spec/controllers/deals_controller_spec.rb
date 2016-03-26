require "rails_helper"

RSpec.describe DealsController do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all deals sorted by price into @collection" do
      deal_1 = create(:deal, title: "Deal 1", price: 10)
      deal_2 = create(:deal, title: "Deal 2", price: 20)

      get :index

      expect(subject.send(:collection)).to eq [deal_1, deal_2]
    end
  end

  describe "GET #filter" do
    before(:each) do
      @deal_1 = create(:deal,
        title:    "Best hotel in city", price: 10, deal_type: "single",
        keywords: ["best", "hotel", "in", "city"])

      @deal_2 = create(:deal,
        title:    "Amazing beach in Mission Bay", price: 20, deal_type: "combined",
        keywords: ["amazing", "beach", "in", "mission", "bay"])

      @deal_3 = create(:deal,
        title:    "Palace of drinks and food", price: 30, deal_type: "single",
        keywords: ["palace", "of", "drinks", "and", "food"])

      @deal_4 = create(:deal,
        title:    "Tour around Auckland city", price: 40, deal_type: "combined",
        keywords: ["tour", "around", "auckland", "city"])
    end

    it "responds successfully with an HTTP 200 status code" do
      get :filter
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :filter
      expect(response).to render_template("deals/_deal")
    end

    describe "filtering deals by 'deal_type'" do
      it "loads all 'single' deals sorted by price into @collection" do
        get :filter, deal_type: "single"
        expect(subject.send(:collection)).to eq [@deal_1, @deal_3]
      end

      it "loads all 'combined' deals sorted by price into @collection" do
        get :filter, deal_type: "combined"
        expect(subject.send(:collection)).to eq [@deal_2, @deal_4]
      end
    end

    it "loads all deals with prices lower than '30' into @collection" do
      get :filter, price: 30
      expect(subject.send(:collection)).to eq [@deal_1, @deal_2, @deal_3]
    end

    describe "filtering deals by keywords" do
      it "loads all deals matching 'hotels_tours' keywords into @collection" do
        get :filter, keywords: ["hotels_tours"]
        expect(subject.send(:collection).to_a).to eq [@deal_1, @deal_4]
      end

      it "loads all deals matching 'beaches_fun' keywords into @collection" do
        get :filter, keywords: ["beaches_fun"]
        expect(subject.send(:collection).to_a).to eq [@deal_2]
      end

      it "loads all deals matching 'drinks_food' keywords into @collection" do
        get :filter, keywords: ["drinks_food"]
        expect(subject.send(:collection).to_a).to eq [@deal_3]
      end
    end
  end

  describe "GET #show" do
    before(:each) do
      @deal = create(:deal)
      get :show, id: @deal.id
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end

    it "loads deal into @deal" do
      expect(assigns(:deal)).to eq @deal
    end
  end

end
