module Eson
  module HTTP
    module Indices
      module Snapshot
        include Shared::Indices::Snapshot
        extend API

        request_method :post

        def path
          unless indices.empty?
            "/{indices}/_gateway/snapshot"
          else
            "/_gateway/snapshot"
          end
        end
      end
    end
  end
end