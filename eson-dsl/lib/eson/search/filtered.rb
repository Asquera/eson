module Eson
  module Search
    class Filtered
      include Filters
      include Queries

      include Query

      # @macro eson.query
      short_name :filtered

      attr_accessor :type
    end
  end
end