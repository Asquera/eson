module ElasticSearch
  module Search
    class GeoBoundingBox < FieldBased
      include Filter

      short_name :geo_bounding_box
      attr_accessor :field, :options

      def initialize(field)
        self.field = field
        self.options = {}
      end

      def top_left(location, *args)
        unless args.empty?
          location + args
        end
        options[:top_left] = location
      end

      def bottom_right(location, *args)
        unless args.empty?
          location + args
        end
        options[:bottom_right] = location
      end

      def to_query_hash
        { name => {field => options } }
      end
    end
  end
end