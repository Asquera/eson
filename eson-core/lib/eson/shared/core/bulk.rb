module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:Bulk#parameters}
    # {include:Bulk#source_param}
    # {include:Bulk#multi_index}
    # {include:Bulk#multi_types}
    module Bulk
      extend API

      # @!macro source_param
      source_param :bulk
      # @!macro parameters
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
