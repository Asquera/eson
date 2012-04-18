module Eson
  module HTTP
    module Percolate
      include Shared::Percolate
      extend API

      def path
        '/{index}/{type}/_percolate'
      end
      
      def request_method
        :post
      end
    end
  end
end