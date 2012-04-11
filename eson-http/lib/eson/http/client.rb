module Eson
  module HTTP
    class Client < Eson::Client
      DEFAULT_OPTS = {
                       :server => "http://localhost:9200",
                       :protocol => Eson::HTTP
                     }

      def initialize(opts = {})
        opts = DEFAULT_OPTS.merge(:plugins => default_plugins).merge(opts)
        super(opts)
      end
      
      private
        def default_plugins
          [Eson::StatusHandler, Eson::ResponseParser].tap do |plugins|
            if defined? Eson::QueryPlugin
              plugins.unshift(Eson::QueryPlugin)
            end
          end
        end
    end
  end
end