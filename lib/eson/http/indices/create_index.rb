module Eson
  module HTTP
    module CreateIndex
      include Shared::CreateIndex
      extend API
      
      request_method :put      
      
      def path
        '/{index}'
      end
    end
  end
end