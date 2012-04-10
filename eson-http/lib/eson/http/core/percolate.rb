module Eson
  module HTTP
    module Percolate
      include Shared::Percolate
      extend API

      def path
        if query
          '/_percolator/{index}/{type}'
        else
          '/{index}/{type}/_percolate'
        end
      end
      
      def request_method
        if doc
          :post
        else
          :put
        end
      end
    end
  end
end