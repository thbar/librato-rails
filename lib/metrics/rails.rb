#require 'activesupport/notifications'

require 'metrics/rails/version'

module Metrics
  module Rails

    class << self
    
      def client
      end
  
      def counters
        @counter_cache ||= CounterCache.new
      end
    
      def increment(key, by=1)
        counters.increment(key, by)
      end
    
    end
  
    class CounterCache
      extend Forwardable
    
      #def_delegators :@cache, :[]
    
      def initialize
        @cache = {}
      end
    
      def [](key)
        @cache[key.to_s]
      end
    
      def increment(counter, by=1)
        counter = counter.to_s
        @cache[counter] ||= 0
        @cache[counter] += by
      end
    
    end

  end
end

# ActiveSupport::Notifications.subscribe /process_action.action_controller/ do |*args|
#   
#   event = ASN::Event.new(*args)
#   controller = event.payload[:controller]
#   action = event.payload[:action]
#   
#   format = event.payload[:format] || "all"
#   format = "all" if format == "*/*"
#   status = event.payload[:status]
#   exception = event.payload[:exception]
#   
#   key = 'request.'
#   page_key = "request.#{controller}.#{action}_#{format}."
#   
#   Metric::Rails.increment "#{key}.total"
# end