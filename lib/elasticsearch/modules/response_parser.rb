module ElasticSearch
  module ResponseParser
    def call(*args)
      parse(super)
    end
    
    def parse(response)
      MultiJson.decode(response.body) if response.body
    end
  end
end