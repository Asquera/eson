module Eson
  module HTTP
    module Indices
      module ClearCache
        include Shared::Indices::ClearCache
        extend API

        request_method :post

        def path
          if index
            "/{indices}/_cache/clear"
          else
            "/_cache/clear"
          end
        end
      end
    end
  end
end