module Eson
  module HTTP
    module Indices
      module Analyze
        include Shared::Indices::Analyze
        extend API

        request_method :put

        def path
          '/{index}/_analyze'
        end
      end
    end
  end
end