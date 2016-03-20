class CreateCombinedDeals

  attr_reader :deals

  def initialize(deals)
    @deals = deals
  end

  def call
    deals.each_with_index do |deal, index|
      # take the first deal, the third one, the fifth one...
      if index % 2 == 0
        first_deal  = deals[index]
        second_deal = deals[index + 1]

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
  end

end
