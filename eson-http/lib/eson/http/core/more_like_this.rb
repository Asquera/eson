module Eson
  module HTTP
    module MoreLikeThis
      include Shared::MoreLikeThis
      extend API

      request_method :get

      def path
        "{index}/{type}/{id}/_mlt"
      end
    end
  end
end