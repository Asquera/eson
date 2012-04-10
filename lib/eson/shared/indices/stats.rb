module Eson
  module Shared
    module IndexStats
      extend API
      multi_index true

      parameters :docs,
                 :store,
                 :indexing,
                 :get,
                 :search,
                 :merge,
                 :flush,
                 :refresh,
                 :clear,
                 :types
    end
  end
end