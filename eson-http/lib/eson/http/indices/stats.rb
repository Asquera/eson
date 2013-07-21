module Eson
  module HTTP
    module Indices
      module IndexStats
        include Shared::Indices::IndexStats
        extend API

        request_method :get

        def path
          unless indices.empty?
            "/{indices}/_stats"
          else
            "/_stats"
          end
        end
      end
    end
  end
end