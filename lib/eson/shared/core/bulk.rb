module Eson
  module Shared
    module Bulk
      extend API

      source_param :bulk
      parameters :bulk

      def bulk
        @bulk ||= []
      end

      def <<(request)
        bulk << request
      end

      def index(args, immediate = nil)
        self << client.index(args, false)
      end

      def delete(args, immediate = nil)
        self << client.delete(args, false)
      end
    end
  end
end