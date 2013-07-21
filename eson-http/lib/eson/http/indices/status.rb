module Eson
  module HTTP
    module Indices
      module Status
        include Shared::Indices::Status
        extend API

        request_method :get

        def path
          if !indices.empty?
            "/{indices}/_status"
          else
            "/_status"
          end
        end
      end
    end
  end
end