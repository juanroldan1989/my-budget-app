namespace :get do
  namespace :deals do
    namespace :from do
      task book_me: :environment do
        puts "*** Retrieving deals from www.bookme.co.nz ..."

        service = BookMe::PersistDeals.new
        service.call

        puts "*** *** Done!"
        puts
      end

      task event_finda: :environment do
        puts "*** Retrieving deals from www.eventfinda.co.nz ..."

        service = EventFinda::PersistDeals.new
        service.call

        puts "*** *** Done!"
        puts
      end
    end
  end
end
