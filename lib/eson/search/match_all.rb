module Eson
  module Search
    class MatchAll
      include Query
      
      short_name :match_all
      
      attr_accessor :boost
      
      def initialize(params = {})
        self.boost = params.delete(:boost)
      end
      
      def to_query_hash 
        param = boost ? {:boost => self.boost} : {}
        {:match_all => param }
      end
    end
  end
end