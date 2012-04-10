module Eson
  module Shared
    module CreateIndex
      extend API
      
      multi_index false
      
      parameters :settings, :mappings
      
      source_param :settings, :mappings
    end
  end
end