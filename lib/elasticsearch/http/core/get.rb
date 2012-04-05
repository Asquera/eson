module Eson
  module HTTP
    module Get
      include Shared::Get
      extend API
      
      request_method :get
      
      def path
        "{index}/{type}/{id}"
      end
      
    end
  end
end