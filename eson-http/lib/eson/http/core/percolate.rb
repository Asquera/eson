module Eson
  module HTTP
    module Core
      module Percolate
        include Shared::Core::Percolate
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
end