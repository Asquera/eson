module Eson
  module HTTP
    module Indices
      module Flush
        include Shared::Indices::Flush
        extend API

        request_method :post

        def path
          unless indices.empty?
            "/{indices}/_flush"
          else
            "/_flush"
          end
        end
      end
    end
  end
end