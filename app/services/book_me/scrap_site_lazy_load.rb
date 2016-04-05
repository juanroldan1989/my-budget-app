require "json"
require "open-uri"
require "nokogiri"

module BookMe
  class ScrapSiteLazyLoad

    def results
      deals.collect do |hash|
        puts "*** url: #{set_url(hash)}"
        scrap_book_me_deal_service(set_url(hash))
      end
    end

    private

    def urls
      [
        "https://www.bookme.co.nz/bookings/json/home/deals?region=auckland&begin=1&end=20&filter=discount&classification=Activities",
        "https://www.bookme.co.nz/bookings/json/home/deals?region=auckland&begin=21&end=40&filter=discount&classification=Activities",
        "https://www.bookme.co.nz/bookings/json/home/deals?region=auckland&begin=41&end=60&filter=discount&classification=Activities",
        "https://www.bookme.co.nz/bookings/json/home/deals?region=auckland&begin=61&end=80&filter=discount&classification=Activities"
      ]
    end

    def deals
      list = []

      urls.collect do |url|
        page     = Nokogiri::HTML(open(url))
        response = JSON.parse(page)

        list << response["deals"]
      end

      list.flatten
    end

    def set_url(hash)
      "https://www.bookme.co.nz#{hash['href']}".gsub("–", "")
    end

    def scrap_book_me_deal_service(url)
      ScrapSiteDeal.new(url).call
    end
  end
end
