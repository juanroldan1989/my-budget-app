require "open-uri"
require "nokogiri"

class ScrapBookMe

  attr_reader :page

  def initialize
    @page = Nokogiri::HTML(open("https://www.bookme.co.nz/bookings/auckland/home"))
  end

  def results
    items.collect do |item|
      puts "*** url: #{set_url(item)}"
      scrap_book_me_deal_service(set_url(item))
    end
  end

  private

  def items
    page.css(".productCard")
  end

  def set_url(item)
    # item.attributes.first[1].value => /bookings/auckland/activity/taste-of-nz-harbour-cruise-–-including-a-selection-of-nz-food-wine/3064
    "https://www.bookme.co.nz#{item.attributes.first[1].value}".gsub("–", "")
  end

  def scrap_book_me_deal_service(url)
    ScrapBookMeDeal.new(url).call
  end

end

# For references:
# https://www.chrismytton.uk/2015/01/19/web-scraping-with-ruby/
