class DealsController < ApplicationController

  # filter's order is important
  has_scope :by_type,     as: :deal_type
  has_scope :by_price,    as: :price
  has_scope :by_keywords, as: :keywords, type: :array
  has_scope :by_sort,     as: :sort_by

  helper_method :collection
  helper_method :combined_deals
  helper_method :single_deals

  def index
  end

  def single
  end

  def combined
  end

  def show
    @deal = Deal.find params[:id]
  end

  def filter
    render partial: deal_filter.results
  end

  private

  def collection
    @collection ||= deal_filter.results
  end

  def deal_filter
    @deal_filter ||= apply_scopes(DealFilter.new.by_sort("price"))
  end

  def single_deals
    @single_deals ||=
      DealFilter.new.by_type("single").by_sort("price").results
  end

  def combined_deals
    @combined_deals ||=
      DealFilter.new.by_type("combined").by_sort("price").results
  end
end
