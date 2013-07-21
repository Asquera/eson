module Eson
  module Shared
    module Core
      # Requests using this API have the following properties:
      #
      # {include:Index#parameters}
      # {include:Index#source_param}
      # {include:Index#multi_index}
      # {include:Index#multi_types}
      module Index
        extend API

        # @!macro no_multi_index
        multi_index false

        # @!macro source_param
        source_param :doc

        # @!macro parameters
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
          :timeout,
          :ttl,
          :timestamp
        )

        alias :document :doc

        def item=(item)
          warn("item= is deprecated and replaced by doc=")
          self.doc = item
        end
      end
    end
  end
end
