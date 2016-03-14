class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string  :title
      t.text    :description
      t.string  :deal_type
      t.decimal :min_price,  precision: 10, scale: 2, default: 0.0
      t.decimal :max_price,  precision: 10, scale: 2, default: 0.0
      t.decimal :price,      precision: 10, scale: 2, default: 0.0
      t.text    :price_text, array: true, default: []
      t.text    :image_urls, array: true, default: []
      t.text    :links,      array: true, default: []
      t.text    :keywords,   array: true, default: []

      t.timestamps
    end

    add_index :deals, :title
    add_index :deals, :deal_type
    add_index :deals, :min_price
    add_index :deals, :max_price
    add_index :deals, :price
    add_index :deals, :price_text
    add_index :deals, :keywords
  end
end
