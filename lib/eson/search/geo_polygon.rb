module Eson
  module Search
    class GeoPolygon
      include Filter

      filter :geo_polygon
      attr_accessor :field, :options

      def initialize(field, options = {})
        self.field = field
        self.options = options
      end

      def points(points = nil)
        if points
          @points = points
        else
          @points ||= []
        end
      end

      def point(point)
        points << point
      end

      def to_query_hash
        { name => options.merge({ field => {:points => points} }) }
      end
    end
  end
end