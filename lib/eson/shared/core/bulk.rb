module Eson
  module Shared
    module Bulk
      extend API
      
      multi_index false
      
      source_param :bulk
      parameters :bulk
      
      def bulk
        @bulk ||= []
      end
      
      # this is preliminary
      def <<(request)
        bulk << request
      end
    end
  end
end