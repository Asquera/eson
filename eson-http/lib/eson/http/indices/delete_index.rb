module Eson
  module HTTP
    module DeleteIndex
      include Shared::DeleteIndex
      extend API
      
      request_method :delete
      
      def path
        "/{indices}"
      end
    end
  end
end