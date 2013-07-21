module Eson
  module HTTP
    module Indices
      module DeleteTemplate
        include Shared::Indices::DeleteTemplate
        extend API

        request_method :delete

        def path
          "/_template/{name}"
        end
      end
    end
  end
end