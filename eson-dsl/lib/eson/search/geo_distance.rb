module Eson
  module Search
    class GeoDistance
      include Filter
      include Facet

      # @macro eson.filter
      filter :geo_distance
      # @macro eson.facet
      facet :geo_distance

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