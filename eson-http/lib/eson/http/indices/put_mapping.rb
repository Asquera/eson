module Eson
  module HTTP
    module Indices
      module PutMapping
        include Shared::Indices::PutMapping
        extend API

        request_method :put

        def path
          if type && !indices.empty?
            "/{indices}/{type}/_mapping"
          end
        end
      end
    end
  end
end