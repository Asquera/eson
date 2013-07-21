module Eson
  module HTTP
    module Core
      module MultiGet
        include Shared::Core::MultiGet
        extend API

        request_method :get

        def bare_path
          unless type
            path = "{index}/{type}/"
          else
            path = "{index}/"
          end
        end

        def path
          path = bare_path + "_mget"
        end
      end
    end
  end
end