class DealsController < ApplicationController

  # filter's order is important
  has_scope :by_type,     as: :deal_type
  has_scope :by_budget,   as: :budget
  has_scope :by_keywords, as: :keywords, type: :array
  has_scope :by_sort,     as: :sort_by

  helper_method :combined_deals
  helper_method :single_deals

  def index
  end

  def single
  end

  def combined
  end

  private

  def deal_filter
    @deal_filter ||= apply_scopes(DealFilter.new)
  end

  def single_deals
    @single_deals ||= DealFilter.new.by_type("single").results
  end

  def combined_deals
    @combined_deals ||= DealFilter.new.by_type("combined").results
  end
end
