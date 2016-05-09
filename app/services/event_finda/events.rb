module EventFinda
  class Events

    attr_reader :response

    def initialize
      @response = EventFindaRuby::Events.new.results
    end

    def results
      response.collect do |event|
        puts "*** url: #{event['url']}"
        format_event(event)
      end
    end

    private

    def format_event(event)
      FormatEvent.new(event).call
    end

  end
end
