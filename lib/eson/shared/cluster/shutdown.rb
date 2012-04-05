module Eson
  module Shared
    module Shutdown
      #TODO fully implement and test this
      extend API
      
      multi_index false

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