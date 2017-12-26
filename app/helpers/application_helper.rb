module ApplicationHelper

  def deal_price_text(deal)
    if deal.price.to_i > 0
      "#{deal.deal_type.camelize} deal for $#{deal.price}".html_safe
    else
      "#{deal.price_text.first}".html_safe
    end
  end

  def keywords_options
    [
      ["hotels", "Hotels & Tours"],
      ["beaches", "Beaches & Fun"],
      ["drinks", "Drinks & Food"]
    ]
  end

  def price_options
    [
      ["50", "$50"],
      ["100", "$100"],
      ["150", "$150"],
      ["200", "$200"]
    ]
  end
end
