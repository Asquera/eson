module Eson
  module HTTP
    module GetAliases
      include Shared::GetAliases
      extend API
      
      request_method :get
      
      def path
        "/_aliases"
      end
    end
  end
end