module Eson
  module HTTP
    module Indices
      module PutTemplate
        include Shared::Indices::PutTemplate
        extend API

        request_method :put

        def path
          "/_template/{name}"
        end
      end
    end
  end
end