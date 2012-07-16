module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:Aliases#parameters}
    # {include:Aliases#source_param}
    # {include:Aliases#multi_index}
    # {include:Aliases#multi_types}
    module Aliases
      extend API
      
      no_indices true
      
      # @!macro parameters
      parameters :actions
      # @!macro source_param
      source_param [:actions]
      
      def add(index, aka)
        actions << {"add" => { "index" => index, "alias" => aka}}
      end
      
      def remove(index, aka)
        actions << {"remove" => { "index" => index, "alias" => aka}}
      end
      
      def actions
        @actions ||= []
      end
    end
  end
end
