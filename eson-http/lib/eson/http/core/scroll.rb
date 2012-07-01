module Eson
  module HTTP
    module Scroll
      include Shared::Scroll
      extend API
      
      request_method :get
      
      def path
        "_search/scroll"
      end
    end
  end
end