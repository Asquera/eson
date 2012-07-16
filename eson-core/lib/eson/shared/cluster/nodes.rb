module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:Nodes#parameters}
    # {include:Nodes#source_param}
    # {include:Nodes#multi_index}
    # {include:Nodes#multi_types}
    module Nodes
      extend API
      
      # @!macro no_multi_index
      multi_index false
      
      # @!macro parameters
      parameters :nodes
      
      def nodes
        Array(@nodes)
      end
    end
  end
end
