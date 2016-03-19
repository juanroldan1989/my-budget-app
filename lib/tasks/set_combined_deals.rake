namespace :deals do
  namespace :set do
    task combined: :environment do
      puts "*** Setting up combined deals..."

      puts "*** *** Combined for 50 dollars..."
      deals_to_combine = Deal.by_type("single").by_price_lower_than(25)
      counter          = deals_to_combine.size

      deals_to_combine.each_with_index do |deal, index|
        # take the first deal, the third one, the fifth one...
        if index % 2 == 0
          first_deal  = deals_to_combine[index]
          second_deal = deals_to_combine[index + 1]

          if first_deal.present? && second_deal.present?
            Deal.create(
              title:       "#{first_deal.title} & #{second_deal.title}",
              description: (first_deal.description + second_deal.description),
              deal_type:   "combined",
              min_price:   first_deal.min_price < second_deal.min_price ? first_deal.min_price : second_deal.min_price,
              max_price:   first_deal.max_price < second_deal.max_price ? first_deal.max_price : second_deal.min_price,
              price:       (first_deal.price.to_i + second_deal.price.to_i),
              price_text:  (first_deal.price_text + second_deal.price_text),
              image_urls:  [first_deal.image_urls, second_deal.image_urls].flatten.compact,
              links:       first_deal.links    + second_deal.links,
              keywords:    first_deal.keywords + second_deal.keywords
            )
          end
        end
      end
      puts "*** *** Done!"

      puts
      puts "*** *** Combined for 100 dollars..."
      deals_to_combine = Deal.by_type("single").by_price_higher_than(25).by_price_lower_than(50)
      counter          = deals_to_combine.size

      deals_to_combine.each_with_index do |deal, index|
        # take the first deal, the third one, the fifth one...
        if index % 2 == 0
          first_deal  = deals_to_combine[index]
          second_deal = deals_to_combine[index + 1]

          if first_deal.present? && second_deal.present?
            Deal.create(
              title:       "#{first_deal.title} & #{second_deal.title}",
              description: (first_deal.description + second_deal.description),
              deal_type:   "combined",
              min_price:   first_deal.min_price < second_deal.min_price ? first_deal.min_price : second_deal.min_price,
              max_price:   first_deal.max_price < second_deal.max_price ? first_deal.max_price : second_deal.min_price,
              price:       (first_deal.price.to_i + second_deal.price.to_i),
              price_text:  (first_deal.price_text + second_deal.price_text),
              image_urls:  [first_deal.image_urls, second_deal.image_urls].flatten.compact,
              links:       first_deal.links    + second_deal.links,
              keywords:    first_deal.keywords + second_deal.keywords
            )
          end
        end
      end
      puts "*** *** Done!"

      puts
      puts "*** *** Combined for 150 dollars..."
      deals_to_combine = Deal.by_type("single").by_price_higher_than(50).by_price_lower_than(75)
      counter          = deals_to_combine.size

      deals_to_combine.each_with_index do |deal, index|
        # take the first deal, the third one, the fifth one...
        if index % 2 == 0
          first_deal  = deals_to_combine[index]
          second_deal = deals_to_combine[index + 1]

          if first_deal.present? && second_deal.present?
            Deal.create(
              title:       "#{first_deal.title} & #{second_deal.title}",
              description: (first_deal.description + second_deal.description),
              deal_type:   "combined",
              min_price:   first_deal.min_price < second_deal.min_price ? first_deal.min_price : second_deal.min_price,
              max_price:   first_deal.max_price < second_deal.max_price ? first_deal.max_price : second_deal.min_price,
              price:       (first_deal.price.to_i + second_deal.price.to_i),
              price_text:  (first_deal.price_text + second_deal.price_text),
              image_urls:  [first_deal.image_urls, second_deal.image_urls].flatten.compact,
              links:       first_deal.links    + second_deal.links,
              keywords:    first_deal.keywords + second_deal.keywords
            )
          end
        end
      end
      puts "*** *** Done!"

    end
  end
end
