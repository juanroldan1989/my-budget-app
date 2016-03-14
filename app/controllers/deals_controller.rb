class DealsController < ApplicationController

  # filter's order is important
  has_scope :by_type,     as: :deal_type
  has_scope :by_budget,   as: :budget
  has_scope :by_keywords, as: :keywords, type: :array
  has_scope :by_sort,     as: :sort_by

  def index
    @results = deal_filter.results
  end

  private

  def deal_filter
    @deal_filter ||= apply_scopes(DealFilter.new)
  end
end
