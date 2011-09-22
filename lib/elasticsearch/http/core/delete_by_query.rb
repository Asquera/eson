module ElasticSearch
  module HTTP
    module DeleteByQuery
      extend API
      include Search
      
      request_method :delete
      
    end
  end
end