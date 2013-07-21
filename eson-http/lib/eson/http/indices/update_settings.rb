module Eson
  module HTTP
    module Indices
      module UpdateSettings
        include Shared::Indices::UpdateSettings
        extend API

        request_method :put

        def path
          unless indices.empty?
            "/{indices}/_settings"
          else
            "/_settings"
          end
        end
      end
    end
  end
end