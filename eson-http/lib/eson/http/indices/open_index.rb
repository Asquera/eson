module Eson
  module HTTP
    module Indices
      module OpenIndex
        include Shared::Indices::OpenIndex
        extend API

        request_method :post

        def path
          "/{indices}/_open"
        end
      end
    end
  end
end