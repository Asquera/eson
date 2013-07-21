module Eson
  module HTTP
    module Indices
      module GetSettings
        include Shared::Indices::GetSettings
        extend API

        request_method :get

        def path
          if index
            "/{indices}/_settings"
          else
            "/_settings"
          end
        end
      end
    end
  end
end