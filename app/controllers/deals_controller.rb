# Check combined deals including different events
class DealsController < ApplicationController

  has_scope :by_type,     as: :deal_type
  has_scope :by_price,    as: :price
  has_scope :by_keywords, as: :keywords, type: :array
  has_scope :by_sort,     as: :sort_by

  helper_method :collection

  def index
  end

  def show
    @deal = Deal.find params[:id]
  end

  def filter
    render partial: collection
  end

  private

  def collection
    @collection ||= deal_filter.results
  end

  def deal_filter
    @deal_filter ||= apply_scopes(DealFilter.new.by_sort("price"))
  end
end
