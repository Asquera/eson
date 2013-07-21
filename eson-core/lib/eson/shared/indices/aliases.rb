module Eson
  module Shared
    module Indices
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

        # Adds an alias to the alias request. The aliased index and the alias
        # are given directly, while further options can be provided in the
        # options hash.
        #
        # @param index [String,Symbol] The index name.
        # @param aka [String, Symbol] The aliased name.
        # @options options [String, Symbol] :routing
        #   The routing parameter that should be used on all requests.
        # @options options [String, Symbol] :search_routing
        #   Like routing, but only for search requests
        # @options options [String, Symbol] :index_routing
        #   Like routing, but only for index requests
        # @options options [Hash] :filter
        #   A filter definition to use on this alias
        def add(index, aka, options = {})
          actions << {:add => { :index => index, :alias => aka}.merge!(options)}
        end

        # Removes an alias. To remove and alias, both the original index and
        # the alias have to be given.
        #
        # @param index [String,Symbol] The index name.
        # @param aka [String, Symbol] The aliased name.
        def remove(index, aka)
          actions << {:remove => { :index => index, :alias => aka}}
        end

        #@api private
        def actions
          @actions ||= []
        end
      end
    end
  end
end
