module Eson
  module HTTP
    module DeleteTemplate
      include Shared::DeleteTemplate
      extend API
      
      request_method :delete
      
      def path
        "/_template/{name}"
      end
    end
  end
end