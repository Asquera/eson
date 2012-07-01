module Eson
  module More
    module ExtractSource
      module Functions
        
      end

      # Extracts doc sources as hashes from a search result.
      # 
      # @param [Hash] response the response body as returned by a search request.
      def extract_source(response)
        response["hits"]["hits"].map {|h| h["_source"] }
      end
    end
  end
end

Eson::Client.class_eval {
  include Eson::More::ExtractSource
}