module ElasticSearch
  module ResponseParser
    class JSONParseError < ElasticSearch::Error
      attr_accessor :source, :response
    end
    
    def call(*args)
      parse(super)
    end
    
    def parse(response)
      begin
        MultiJson.decode(response.body) if response.body
      rescue MultiJson::DecodeError
        error = JSONParseError.new
        error.source = response.body
        error.response = response
        raise error
      end
      
    end
  end
end