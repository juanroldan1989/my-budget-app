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
end
