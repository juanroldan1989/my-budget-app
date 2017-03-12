module ApplicationHelper

  def deal_price_text(deal)
    if deal.price.to_i > 0
      "#{deal.deal_type.camelize} deal for $#{deal.price}".html_safe
    else
      "#{deal.price_text.first}".html_safe
    end
  end
end
