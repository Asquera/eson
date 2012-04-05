module Eson
  module Shared
    module Analyze
      extend API
      
      multi_index false
      
      attr_accessor :text, :analyzer, :format
    end
  end
end