module Eson
  module HTTP
    module Core
      module Explain
        include Shared::Core::Explain
        extend API

        request_method :get

        def path
          "/{index}/{type}/{id}/_explain"
        end
      end
    end
  end
end