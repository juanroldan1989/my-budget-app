class Deal < ActiveRecord::Base

  KEYWORDS = {
    hotels_tours:
    %w( hotel tour accommodation house lodge bed breakfast hostel apart
        pension posada inn),
    beaches_fun:
    %w( beach fun seaside seashore shore coast seaboard water sand
        party night club),
    drinks_food:
    %w( drink food alcohol tipple bottle booze beer pizza bar eat cocktail
        cook baking bake cuisine refreshment meal ration store meat)
  }

  extend FriendlyId
    friendly_id :title, use: [:slugged, :finders] # you can now do MyClass.find('bar')

  # https://github.com/Casecommons/pg_search
  include PgSearch

  scope :by_date,              ->            { order("created_at DESC") }
  # scope :by_start_date,        ->            { order("created_at DESC") }
  scope :by_price,             ->            { order("price ASC") }
  scope :by_price_higher_than, -> (price)    { where("price >= ?", price) }
  scope :by_price_lower_than , -> (price)    { where("price <= ?", price) }
  scope :by_type,              -> (type)     { where(deal_type: type) }

  validates :title,     presence: true, uniqueness: true
  validates :price,     presence: true
  validates :deal_type, presence: true

  before_save :set_keywords

  pg_search_scope :title_search, against: :title,
                    using: {
                      tsearch: {
                        prefix: true, dictionary: "english"
                      }
                    }

  # https://github.com/Casecommons/pg_search#any_word
  pg_search_scope :keywords_search, against: :keywords,
                    using: {
                      tsearch: {
                        prefix: true, dictionary: "english", any_word: true
                      }
                    }

  def is_combined?
    deal_type == "combined"
  end

  # limiting deal's slug to 40 characters
  def normalize_friendly_id(string)
    super[0..39]
  end

  def show_in_map?
    location_lat.present? && location_long.present?
  end

  private

  def set_keywords
    # "combined" deals get their keywords set by rake task
    if self.deal_type == "single"
      self.keywords = self.slug.split("-")
    end
  end
end
