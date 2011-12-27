module ElasticSearch
  module ResponseParser
    class JSONParseError < ElasticSearch::Error
      attr_accessor :source
    end
    
    def call(*args)
      parse(super)
    end
    
    def parse(response)
      begin
        MultiJson.decode(response.body) if response.body
      rescue MultiJson::DecodeError => e
        error = JSONParseError.new(e.message, response)
        error.source = response.body
        raise error
      end
      
    end
  end
end