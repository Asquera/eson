require 'echolon-search'

module ElasticSearch
  module HTTP
    class Client < ElasticSearch::Client
      DEFAULT_OPTS = {
                       :server => "http://localhost:9200",
                       :protocol => ElasticSearch::HTTP,
                       :plugins => [ElasticSearch::QueryPlugin, ElasticSearch::StatusHandler, ElasticSearch::ResponseParser]
                     }

      def initialize(opts = {})
        opts = DEFAULT_OPTS.merge(opts)
        super(opts)
      end
    end
  end
end