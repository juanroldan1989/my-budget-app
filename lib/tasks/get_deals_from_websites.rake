namespace :get do
  namespace :deals do
    task websites: :environment do
      puts "*** Retrieving deals from www.bookme.co.nz ..."

      service = BookMe::PersistDeals.new
      service.call

      puts "*** *** Done!"
      puts

      puts "*** Retrieving deals from www.eventfinda.co.nz ..."

      service = EventFinda::PersistDeals.new
      service.call

      puts "*** *** Done!"
      puts

    end
  end
end
