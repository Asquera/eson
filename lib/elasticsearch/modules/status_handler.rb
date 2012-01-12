module ElasticSearch
  module StatusHandler
    def call(*args)
      handle(super)
    end

    def handle(response)
      case response.status
      when 404
        if /IndexMissingException/.match(response.body)
          raise ElasticSearch::IndexNotFoundError.new(response.body, response)
        else
          raise ElasticSearch::NotFoundError.new(response, response)
        end
      else
        if response.status >= 400
          raise ElasticSearch::Error.new(response[:error], response)
        else
          response
        end
      end
    end
  end
end