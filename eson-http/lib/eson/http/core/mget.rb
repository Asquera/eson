module Eson
  module HTTP
    module MultiGet
      include Shared::MultiGet
      extend API
      
      request_method :get
      
      def bare_path
        unless type
          path = "{index}/{type}/"
        else
          path = "{index}/"
        end
      end
      
      def path
        path = bare_path + "_mget"
      end
      
    end
  end
end