module Eson
  module Search
    class Match < FieldBased
      include Query

      # @macro eson.query
      short_name :match
    end
  end
end