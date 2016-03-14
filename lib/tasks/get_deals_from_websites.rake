namespace :get do
  namespace :deals do
    task websites: :environment do
      puts "*** Retrieving deals from www.bookme.co.nz ..."

      service = ScrapBookMe.new
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
