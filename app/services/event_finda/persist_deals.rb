module EventFinda
  class PersistDeals

    attr_reader :results

    def initialize
      @results = Events.new.results
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
