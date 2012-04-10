module Eson
  module HTTP
    module Aliases
      include Shared::Aliases
      extend API
      
      request_method :post
      
      def path
        '/_aliases'
      end
    end
  end
end