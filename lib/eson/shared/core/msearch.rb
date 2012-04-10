module Eson
  module Shared
    module MultiSearch
      extend API
      
      attr_accessor :type
      
      multi_index true
      
      source_param :msearch
      parameters :msearch,
                 :types

      def msearch
        @msearch ||= []
      end

      def <<(request)
        msearch << request
      end

      def search(args, immediate = true, &block)
        self << client.search(args, false, &block)
      end
      
      def types
        if @types
          Array(@types)
        elsif type
          Array(type)
        else
          []
        end
      end
    end
  end
end