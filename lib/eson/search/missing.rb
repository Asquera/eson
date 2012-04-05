module Eson
  module Search
    class Missing
      include Filter
      
      short_name :missing
      
      attr_accessor :options
      
      def initialize(options = {})
        self.options = options
      end
      
      def to_query_hash
        { name => options }
      end

    end
  end
end