# http://api.eventfinda.co.nz/v2/events.json?row=2&fields=session:(timezone,datetime_start)&q=beach&order=popularity
module EventFinda
  class FormatEvent < Struct.new(:event)

    def call
      {
        title:         event["name"],
        description:   event["description"],
        deal_type:     "single",
        price_text:    [price_text],
        price:         price,
        image_urls:    [image_url],
        links:         [event["url"]],
        location_lat:  event["point"]["lat"],
        location_long: event["point"]["lat"]
      }
    end

    private

    def image_url
      image        = event["images"]["images"].first

      image_sized_8 = image["transforms"]["transforms"].select { |transform|
        transform["transformation_id"] == 8  # "width": 190, "height": 127
      }.first

      image_sized_2 = image["transforms"]["transforms"].select { |transform|
        transform["transformation_id"] == 2 # "width": 80,  "height": 80
      }.first

      image_sized_15 = image["transforms"]["transforms"].select { |transform|
        transform["transformation_id"] == 15 # "width": 75,  "height": 75
      }.first

      if image_sized_8.present?
        image_sized_8["url"]
      elsif image_sized_2.present?
        image_sized_2["url"]
      elsif image_sized_15.present?
        image_sized_15["url"]
      else
        "http://cdn.eventfinda.co.nz/images/global/iconVenue-8.png"
      end
    end

    def price_text
      if event["ticket_types"]["ticket_types"].any?
        event["ticket_types"]["ticket_types"].first["name"]
      else
        "Price to confirm"
      end
    end

    def price
      if event["ticket_types"]["ticket_types"].any?
        event["ticket_types"]["ticket_types"].first["price"]
      else
        0
      end
    end

  end
end
