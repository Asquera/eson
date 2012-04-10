module Eson
  module Shared
    module Index
      extend API

      multi_index false
      
      source_param :doc
      
      parameters(
        :type, 
        :id,
        :doc,
        :version,
        :op_type,
        :routing,
        :parent,
        :percolate,
        :replication,
        :consistency,
        :refresh,
        :timeout
      )
      
      alias :document :doc
      
      def item=(item)
        warn("item= is deprecated and replaced by doc=")
        self.doc = item
      end
    end
  end
end