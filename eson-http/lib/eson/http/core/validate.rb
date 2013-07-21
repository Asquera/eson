module Eson
  module HTTP
    module Core
      module Validate
        include Shared::Core::Validate
        extend API

        request_method :get

        def path
          if type
            "/{index}/{type}/_validate/query"
          else
            "/{index}/_validate/query"
          end
        end
      end
    end
  end
end