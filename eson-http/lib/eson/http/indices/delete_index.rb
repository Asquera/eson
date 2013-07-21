module Eson
  module HTTP
    module Indices
      module DeleteIndex
        include Shared::Indices::DeleteIndex
        extend API

        request_method :delete

        def path
          "/{indices}"
        end
      end
    end
  end
end