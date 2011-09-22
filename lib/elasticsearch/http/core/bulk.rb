module ElasticSearch
  module HTTP
    module Bulk
      include Shared::Bulk
      extend API
      
      request_method :put
      
      def path
        '/_bulk'
      end
      
      def source
        bulk.map {|r| serialize_request(r)}.join
      end
      
      def serialize_request(request)
        case request
        when ElasticSearch::HTTP::Index
          MultiJson.encode({ "index" => to_params_hash(request) }) << "\n" << request.source << "\n"
        when ElasticSearch::HTTP::Delete
          MultiJson.encode({ "delete" => to_params_hash(request) }) << "\n"
        end
      end
      
      def to_params_hash(r)
        { "_index" => r.index, "_type" => r.type, "_id" => r.id }
      end
    end
  end
end