module Eson
  module HTTP
    module Core
      module Get
        include Shared::Core::Get
        extend API

        request_method :get

        def path
          "{index}/{type}/{id}"
        end
      end
    end
  end
end