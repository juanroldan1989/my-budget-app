class DealFilter

  # 50, 100, 150
  def by_price(price)
    logger.debug "*** by_price: #{price.to_i}"

    use_scope :by_price_lower_than, price.to_i

    self
  end

  def by_keywords(keywords)
    logger.debug "*** by_keywords: #{keywords}"

    use_scope :keywords_search, keywords_list(keywords)

    self
  end

  def by_sort(sort_key)
    logger.debug "*** by_sort: #{sort_key}"

    case sort_key
    when "price"
      use_scope :by_price
    when "date"
      use_scope :by_date
    end

    self
  end

  # single | combined
  def by_type(deal_type)
    logger.debug "*** by_type: #{deal_type}"

    use_scope :by_type, deal_type

    self
  end

  def results
    scope.all
  end

  private

  def base_scope
    Deal
  end

  def logger
    Rails.logger
  end

  def keywords_list(keys)
    keys.collect { |key| Deal::KEYWORDS[key.to_sym] }.flatten.compact
  end

  def scope
    @scope ||= base_scope
  end

  def use_scope(key, *args)
    @scope = scope.send(key, *args)
  end
end
