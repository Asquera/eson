module Eson
  module HTTP
    module Indices
      module Aliases
        include Shared::Indices::Aliases
        extend API

        request_method :post

        def path
          '/_aliases'
        end
      end
    end
  end
end