module Eson
  module Shared
    module Percolate
      extend API
      
      multi_index false
      
      parameters :query,
                 :doc,
                 :prefer_local,
                 :type,
                 :index
      
      source_param :doc, :query
      
    end
  end
end