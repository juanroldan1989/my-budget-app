# Check single events straight from EventFinda's API
class EventsController < ApplicationController

  has_scope :by_keywords_or, as: :keywords, type: :array
  has_scope :by_price_min,   as: :price

  helper_method :collection

  def index
  end

  def filter
    render partial: "events/events"
  end

  private

  def collection
    Rails.cache.fetch("/v1/events/#{search_keys}", expires_in: 1.hour) do
      events_filter.results
        .map { |event_hash| EventFinda::FormatEvent.new(event_hash).call }
    end
  end

  def events_filter
    @events_filter ||= apply_scopes(EventFindaRuby::Events.new)
  end

  def search_keys
    events_filter.filters.map { |key, value| "#{key}/#{value}" }.join("/")
  end
end
