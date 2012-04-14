module Eson
  module Search
    class GeoDistance
      include Filter
      include Facet

      # @macro geo_distance
      #   @yield a block defining options
      #   Generates a `$1` filter or facet, depending on context.
      #   {include:file:eson-dsl/examples/filters/$1.rb}
      #   {include:file:eson-dsl/examples/facets/$1.rb}
      short_name :geo_distance

      attr_accessor :field, :options

      def initialize(field, options = {})
        self.field = field
        self.options = options
      end

      def lat(lat)
        @lat = lat
      end

      def lon(lon)
        @lon = lon
      end

      def to_query_hash
        { name => options.merge({ field => {:lat => @lat, :lon => @lon } }) }
      end
    end
  end
end