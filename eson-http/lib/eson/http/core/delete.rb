module Eson
  module HTTP
    module Core
      module Delete
        include Shared::Core::Delete
        extend API

        request_method :delete

        def path
          "/{index}/{type}/{id}"
        end
      end
    end
  end
end