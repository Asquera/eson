module Eson
  module Search
    class GeoDistanceRange
      include Filter

      short_name :geo_distance_range
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