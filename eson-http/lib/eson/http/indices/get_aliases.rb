module Eson
  module HTTP
    module Indices
      module GetAliases
        include Shared::Indices::GetAliases
        extend API

        request_method :get

        def path
          "/_aliases"
        end
      end
    end
  end
end