module Eson
  module Shared
    module MultiGet
      extend API
      
      multi_index false
      
      source_param :docs,
                   :ids
                    
      parameters :type,
                 :docs,
                 :ids
    end
  end
end