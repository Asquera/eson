module Eson
  module HTTP
    module Indices
      module DeleteMapping
        include Shared::Indices::DeleteMapping
        extend API

        request_method :delete

        def path
          if type && !indices.empty?
            "/{indices}/{type}"
          end
        end
      end
    end
  end
end