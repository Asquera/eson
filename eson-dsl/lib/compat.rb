# Since elasticsearch 0.19.9, `text` is called `match`
#
# For backwards compatibility reasons, `text` will be generated until
# all versions of ES below 0.19.9 are not supported anymore.
#
# `match` can be used in the DSL, though.
module Eson
  module Search
    module Queries
      module QueryMethods
        alias :match :text
      end
    end
  end
end