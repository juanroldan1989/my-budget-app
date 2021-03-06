require "open-uri"
require "nokogiri"

module BookMe
  class ScrapSiteDeal

    attr_reader :deal_url
    attr_reader :page

    # deal_url => e.g.: https://www.bookme.co.nz/bookings/auckland/activity/taste-of-nz-harbour-cruise-%E2%80%93-including-a-selection-of-nz-food-wine/3064
    def initialize(deal_url)
      @deal_url = deal_url
      @page     = Nokogiri::HTML(open(deal_url))
    end

    def call
      {
        title:       page.css(".activityWrapper h1").text,
        description: [sanitize_description],
        deal_type:   "single",
        price_text:  [sanitize_price_text],
        price:       sanitize_price,
        image_urls:  [sanitize_image_url],
        links:       [deal_url]
      }
    end

    private

    def sanitize_description
      "#{page.css(".activityWrapper .activityText p").children.to_a[1]} | " +
      "#{page.css(".activityWrapper .activityText p").children.to_a[2]}"
    end

    def sanitize_price_text
      with_text = page.css(".activityWrapper .activityText li")
        .to_a.collect { |item| item if item.text.present? }.compact

      if with_text.empty?
        with_text = page.css(".activityWrapper .activityText p")
        .to_a.collect { |item| item if item.text.present? }.compact
      end

      @sanitize_price_text ||= if with_text.any?
        with_money = with_text.collect { |item| item if item.text.include?("$") }.compact
        with_money.any? ? with_money.first.text : "Price to confirm"
      else
        "Price to confirm"
      end
    end

    def sanitize_price
      if @sanitize_price_text == "Price to confirm"
        0
      else
        @sanitize_price_text.scan(/\d+/).first.to_i
      end
    end

    def sanitize_image_url
      url = page.css(".activityWrapper .activityText .media-li img")
        .first.attributes["data-src"].text

      # url => //www.bookmestatic.net.nz/images/activities/3064_image1_1.jpg

      "http://#{url[2..100]}"
    end
  end
end
