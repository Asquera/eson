module Eson
  module Shared
    module Core
      # Requests using this API have the following properties:
      #
      # @note {include:MultiSearch#parameters}
      # @note {include:MultiSearch#source_param}
      # @note {include:MultiSearch#multi_index}
      # @note {include:MultiSearch#multi_types}
      module MultiSearch
        extend API

        attr_accessor :type

        # @!macro multi_index
        multi_index true

        # @!macro source_param
        source_param :msearch
        # @!macro parameters
        parameters :msearch,
                   :types

        def msearch
          @msearch ||= []
        end

        def <<(request)
          msearch << request
        end

        def search(args, immediate = true, &block)
          self << client.search(args, false, &block)
        end

        def types
          if @types
            Array(@types)
          elsif type
            Array(type)
          else
            []
          end
        end
      end
    end
  end
end
