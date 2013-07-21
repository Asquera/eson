module Eson
  module HTTP
    module Indices
      module GetTemplate
        include Shared::Indices::GetTemplate
        extend API

        request_method :get

        def path
          "/_template/{name}"
        end
      end
    end
  end
end