module Eson
  module HTTP
    class Client < Eson::Client
      DEFAULT_OPTS = {
                       :server => "http://localhost:9200",
                       :protocol => Eson::HTTP,
                       :plugins => [Eson::StatusHandler, Eson::ResponseParser]
                     }

      def initialize(opts = {})
        opts = DEFAULT_OPTS.merge(opts)
        super(opts)
      end
    end
  end
end