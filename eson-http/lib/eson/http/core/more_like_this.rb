module Eson
  module HTTP
    module Core
      module MoreLikeThis
        include Shared::Core::MoreLikeThis
        extend API

        request_method :get

        def path
          "{index}/{type}/{id}/_mlt"
        end
      end
    end
  end
end