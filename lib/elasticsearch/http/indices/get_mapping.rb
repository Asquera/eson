module ElasticSearch
  module HTTP
    module GetMapping
      include Shared::GetMapping
      extend API
      
      request_method :get
      
      def path
        if !types.empty? && !indices.empty?
          "/{-list|,|indices}/{-list|,|types}/_mapping"
        elsif !indices.empty?
          "/{-list|,|indices}/_mapping"
        else
          "/_mapping"
        end
      end
    end
  end
end