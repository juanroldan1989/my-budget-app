module EventFinda
  class Events

    attr_reader :response

    BASE_URL = "http://api.eventfinda.co.nz/v2/events.json".freeze

    def initialize
      @response =
        HTTParty.get("#{BASE_URL}", basic_auth: auth)
    end

    def results
      response["events"].collect do |event|
        puts "*** url: #{event['url']}"
        format_event(event)
      end
    end

    private

    def auth
      {
        username: Rails.application.config.finda_user_name,
        password: Rails.application.config.finda_password
      }
    end

    def format_event(event)
      FormatEvent.new(event).call
    end

  end
end
