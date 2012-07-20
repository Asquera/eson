module Eson
  module HTTP
    # This client is a convenience subclass of {Eson::Client}. It sets sane
    # default parameters and adds the following plugins: {Eson::StatusHandler}
    # for handling response status, {Eson::ResponseParser} to parse JSON
    # responses and return Hashes and {Eson::QueryPlugin} to use the Query DSL
    # directly.
    class Client < Eson::Client
      # Default settings
      DEFAULT_OPTS = {
                       :server => "http://localhost:9200",
                       :protocol => Eson::HTTP
                     }

      # @see Eson::Client
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