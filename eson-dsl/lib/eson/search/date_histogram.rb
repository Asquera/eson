module Eson
  module Search
    class DateHistogram < Histogram

      ##
      # @macro eson.facet
      #   Generates a `$1` facet.
      #   {include:file:eson-dsl/examples/facets/$1.rb}
      short_name :date_histogram

    end
  end
end