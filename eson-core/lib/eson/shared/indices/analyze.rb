module Eson
  module Shared
    module Indices
      # Requests using this API have the following properties:
      #
      # {include:Analyze#parameters}
      # {include:Analyze#source_param}
      # {include:Analyze#multi_index}
      # {include:Analyze#multi_types}
      module Analyze
        extend API

        # @!macro no_multi_index
        multi_index false

        attr_accessor :text, :analyzer, :format, :tokenizer, :field
      end
    end
  end
end