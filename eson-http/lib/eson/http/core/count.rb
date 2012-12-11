module Eson
  module HTTP
    module Count
      include Shared::Search
      extend API
      
      request_method :post
      
      def bare_path
        unless types.empty?
          path = "{indices}/{types}/"
        else
          path = "{indices}/"
        end
      end
      
      def path
        path = bare_path + "_count"
      end
      
      def source
        MultiJson.encode(query)
      end
    end
  end
end