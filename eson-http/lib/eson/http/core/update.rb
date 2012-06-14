module Eson
  module HTTP
    module Update
      include Shared::Update
      extend API
      
      request_method :post

      def path
        "/{index}/{type}/{id}/_update"
      end
    end
  end
end