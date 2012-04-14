module Eson
  module Search
    class FilterFacet
      include Facet
      include Filters
      include FilterMethods

      # @macro eson.facet
      short_name :filter

    end
  end
end