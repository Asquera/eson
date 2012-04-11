module Eson
  module Search
    class DateHistogram < Histogram

      ##
      # @macro eson.facet
      #   Generates a `$1` facet.
      #   @method $1
      #   {include:file:examples/facets/$1.rb}
      #   @see Eson::Search::Facets
      facet :date_histogram

    end
  end
end