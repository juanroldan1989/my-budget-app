class DealFilter

  # 50, 100, 150
  def by_budget(budget)
    logger.debug "*** by_budget: #{budget}"

    use_scope :by_price_lower_than, budget.to_i

    self
  end

  def by_keywords(keywords)
    logger.debug "*** by_keywords: #{keywords}"

    use_scope :keywords_search, keywords

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

  def scope
    @scope ||= base_scope
  end

  def use_scope(key, *args)
    @scope = scope.send(key, *args)
  end
end
