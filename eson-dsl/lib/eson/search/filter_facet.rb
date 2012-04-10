module Eson
  module Search
    class FilterFacet
      include Facet
      include Filters
      include FilterMethods

      # @macro eson.facet
      facet :filter

    end
  end
end