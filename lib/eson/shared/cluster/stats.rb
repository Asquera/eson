module Eson
  module Shared
    module Stats
      extend API
      
      multi_index false
      
      parameters :nodes
      
      def nodes
        Array(@nodes)
      end
    end
  end
end