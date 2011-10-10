module ElasticSearch
  module StatusHandler
    def call(*args)
      handle(super)
    end
    
    def handle(response)
      if response.status >= 400
        raise ElasticSearch::Error.new(response[:error], response)
      else
        response
      end
    end
  end
end