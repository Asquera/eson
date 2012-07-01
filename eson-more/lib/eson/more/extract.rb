module Eson
  module More
    module Extract
      # Extracts doc sources as hashes from a search result.
      # 
      # @param [Hash] response the response body as returned by a search request.
      def extract_sources(response)
        extract_hits(response).map {|h| h["_source"] }
      end

      # Extracts doc hits as hashes from a search result.
      # 
      # @param [Hash] response the response body as returned by a search request.
      def extract_hits(response)
        response["hits"]["hits"]
      end
    end
  end
end

Eson::Client.class_eval {
  include Eson::More::Extract
}