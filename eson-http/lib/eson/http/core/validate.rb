module Eson
  module HTTP
    module Validate
      include Shared::Validate
      extend API
      
      request_method :get

      def path
        if type
          "/{index}/{type}/_validate/query"
        else
          "/{index}/_validate/query"
        end
      end
    end
  end
end