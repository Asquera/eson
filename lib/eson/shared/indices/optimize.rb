module Eson
  module Shared
    module Optimize
      extend API
          
      multi_index true
      
      parameters :max_num_segments,
                 :only_expunge_deletes,
                 :refresh,
                 :flush,
                 :wait_for_merge
    end
  end
end