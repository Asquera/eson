module Eson
  module Shared
    module MultiSearch
      extend API

      source_param :msearch
      parameters :msearch

      def msearch
        @msearch ||= []
      end

      def <<(request)
        msearch << request
      end

      def search(args, immediate = true, &block)
        self << client.search(args, false, &block)
      end
    end
  end
end