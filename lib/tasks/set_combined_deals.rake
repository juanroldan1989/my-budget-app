namespace :deals do
  namespace :set do
    task combined: :environment do
      puts "*** Setting up combined deals..."

      puts "*** *** Combined for 50 dollars..."
      deals_to_combine = Deal.by_type("single").by_price_lower_than(25)

      CreateCombinedDeals.new(deals_to_combine).call
      puts "*** *** Done!"

      puts
      puts "*** *** Combined for 100 dollars..."
      deals_to_combine = Deal.by_type("single").by_price_higher_than(25).by_price_lower_than(50)

      CreateCombinedDeals.new(deals_to_combine).call
      puts "*** *** Done!"

      puts
      puts "*** *** Combined for 150 dollars..."
      deals_to_combine = Deal.by_type("single").by_price_higher_than(50).by_price_lower_than(75)

      CreateCombinedDeals.new(deals_to_combine).call
      puts "*** *** Done!"

      puts "*** *** Combined for 200 dollars..."
      deals_to_combine = Deal.by_type("single").by_price_higher_than(75).by_price_lower_than(100)

      CreateCombinedDeals.new(deals_to_combine).call
      puts "*** *** Done!"

    end
  end
end
