namespace :get do
  namespace :deals do
    task websites: :environment do
      puts "*** Retrieving deals from www.bookme.co.nz ..."

      # Scenario 1: BookMe site displays all listing items at once
      # service = ScrapBookMe.new

      # Scenario 2: BookMe site displays all listing by lazy loading
      service = ScrapBookMeLazyLoad.new
      results = service.results

      puts "*** #{results.size} deals retrieved ! :D"
      puts "*** #{results.size} deals to persist in DB"

      results.each do |deal_hash|
        deal = Deal.create(deal_hash)

        if deal.valid?
          puts "."
        else
          puts "x: #{deal.errors.full_messages}"
        end
      end

      puts "*** *** Done!"
      puts

    end
  end
end
