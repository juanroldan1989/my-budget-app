namespace :deals do
  namespace :set do
    task testing: :environment do
      puts "*** Setting up testing deals..."

      50.times do |deal|
        Deal.create(
          title:       Faker::Commerce.product_name,
          description: Faker::Lorem.paragraph(2),
          deal_type:   "single",
          min_price:   Faker::Number.between(1, 10),
          max_price:   Faker::Number.between(11, 50),
          price:       Faker::Number.between(1, 100),
          image_urls:  [Faker::Company.logo],
          links:       [Faker::Internet.url],
          keywords:    Faker::Hipster.words(8)
        )
      end

      puts "*** *** Done!"

    end
  end
end
