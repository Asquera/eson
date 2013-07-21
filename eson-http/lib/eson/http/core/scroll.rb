module Eson
  module HTTP
    module Core
      module Scroll
        include Shared::Core::Scroll
        extend API

        request_method :get

        def path
          "_search/scroll"
        end
      end
    end
  end
end