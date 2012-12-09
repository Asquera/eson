module Eson
  module More
    module Reindex
      # Reindex a whole index by scrolling the old one and writing to the 
      # new one using a bulk request.
      # 
      # @param [String] from the index to reindex from
      # @param [String] to the index to reindex to
      def reindex(from, to)
        all(:index => from) do |chunk|
          if chunk.size > 0
            bulk do |b|
              chunk.each do |doc|
                b.index :index => to,
                        :type => doc["_type"],
                        :id => doc["_id"],
                        :doc => doc["_source"]
              end
            end
          end
        end
      end
    end
  end
end

Eson::Client.class_eval {
  include Eson::More::Reindex
}