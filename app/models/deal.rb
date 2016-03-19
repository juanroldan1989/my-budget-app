class Deal < ActiveRecord::Base
  extend FriendlyId
    friendly_id :title, use: [:slugged, :finders] # you can now do MyClass.find('bar')

  # https://github.com/Casecommons/pg_search
  include PgSearch

  scope :by_date,              ->            { order("created_at DESC") }
  scope :by_price,             ->            { order("price ASC") }
  scope :by_price_higher_than, -> (price)    { where("price >= ?", price) }
  scope :by_price_lower_than , -> (price)    { where("price <= ?", price) }
  scope :by_type,              -> (type)     { where(deal_type: type) }

  validates :title,     presence: true, uniqueness: true
  validates :price,     presence: true
  validates :deal_type, presence: true

  pg_search_scope :title_search, against: :title,
                    using: {
                      tsearch: {
                        prefix: true, dictionary: "english"
                      }
                    }

  # if populating "keywords" field is too complicated, use this approach:
  # https://github.com/Casecommons/pg_search#tsearch-full-text-search
  pg_search_scope :keywords_search, against: :keywords,
                    using: {
                      tsearch: {
                        prefix: true, dictionary: "english"
                      }
                    }

  def is_combined?
    deal_type == "combined"
  end

  # limiting deal's slug to 40 characters
  def normalize_friendly_id(string)
    super[0..39]
  end

end
