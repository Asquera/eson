module Eson
  module HTTP
    module Indices
      module Segments
        include Shared::Indices::Segments
        extend API

        request_method :get

        def path
          unless indices.empty?
            "/{indices}/_segments"
          else
            "/_segments"
          end
        end
      end
    end
  end
end