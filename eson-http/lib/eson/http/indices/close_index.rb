module Eson
  module HTTP
    module Indices
      module CloseIndex
        include Shared::Indices::CloseIndex
        extend API

        request_method :post

        def path
          "/{indices}/_close"
        end
      end
    end
  end
end