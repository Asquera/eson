module Eson
  module HTTP
    module Explain
      include Shared::Explain
      extend API
      
      request_method :get

      def path
        "/{index}/{type}/{id}/_explain"
      end
    end
  end
end