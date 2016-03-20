module ApplicationHelper

  def deal_price_text(deal)
    if deal.price.to_i > 0
      "<b>#{deal.deal_type.camelize} deal for $#{deal.price}</b>".html_safe
    else
      "<b>#{deal.price_text.first}</b>".html_safe
    end
  end
end
