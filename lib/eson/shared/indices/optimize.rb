module Eson
  module Shared
    module Optimize
      extend API
          
      multi_index true
      
      parameters :max_num_segments,
                 :only_expunge_deletes,
                 :refresh
    end
  end
end