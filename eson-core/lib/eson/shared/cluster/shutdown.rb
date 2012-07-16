module Eson
  module Shared
    # Requests using this API have the following properties:
    #
    # {include:Shutdown#parameters}
    # {include:Shutdown#source_param}
    # {include:Shutdown#multi_index}
    # {include:Shutdown#multi_types}
    module Shutdown
      #TODO fully implement and test this
      extend API
      
      # @!macro no_multi_index
      multi_index false

      # @!macro parameters
      parameters :nodes,
                 :delay,
                 :master,
                 :local,
                 :all
      
      def nodes
        Array(@nodes)
      end
    end
  end
end
