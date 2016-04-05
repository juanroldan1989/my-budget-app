module BookMe
  class PersistDeals

    attr_reader :results

    def initialize
      # Scenario 1: BookMe site displays all listing items at once
      # service = ScrapSite.new

      # Scenario 2: BookMe site displays all listing by lazy loading each page
      @results = ScrapSiteLazyLoad.new.results
    end

    def call
      puts "*** #{results.size} deals retrieved ! :D"
      puts "*** #{results.size} deals to persist in DB"

      results.each do |deal_hash|
        deal = Deal.create(deal_hash)

        if deal.valid?
          print "."
        else
          puts "x: #{deal.errors.full_messages}"
        end
      end
    end

  end
end
