module Eson
  module HTTP
    module Core
      module Index
        include Shared::Core::Index
        extend API

        request_method :put

        def path
          if id
            "/{index}/{type}/{id}"
          else
            "/{index}/{type}"
          end
        end

        def request_method
          if id
            :put
          else
            :post
          end
        end
      end
    end
  end
end