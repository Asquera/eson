module Eson
  module Search
    class Statistical
      include Facet
      
      short_name :statistical
      
      attr_accessor :options
      
      def initialize(options)
        self.options = options
      end
      
      def to_query_hash
        {name => options}
      end
    end
  end
end