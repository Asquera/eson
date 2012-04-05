module Eson
  module Search
    module Node
      attr_accessor :context
      
      def to_query_hash
        values = options
        
        if defined?(super)
          values = values.merge(super)
        end
        
        { name => values }
      end

    end
  end
end