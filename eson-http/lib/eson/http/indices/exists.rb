module Eson
  module HTTP
    module Indices
      module IndexExists
        include Shared::Indices::IndexExists
        extend API

        request_method :head

        def path
          "/{indices}"
        end
      end
    end
  end
end