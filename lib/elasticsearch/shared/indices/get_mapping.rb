module ElasticSearch
  module Shared
    module GetMapping
      extend API
      
      attr_accessor :type
      parameters :types
      
      multi_index true
      
      def types
        @types || Array(@type)
      end
    end
  end
end