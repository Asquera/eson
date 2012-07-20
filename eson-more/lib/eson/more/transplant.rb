module Eson
  module More
    module Transplant
      module Functions
        def self.extract_ids(*args)
          args.map do |d|
            case d
            when String, Fixnum
              d
            when Hash
              d[:id] || d["id"]
            when nil
              d
            else
              d.id
            end
          end
        end

        def self.get_doc(client, old_parent, doc)
          case doc
          when Hash
            doc
          when String
            client.get(:id => doc)
          else
            doc.to_h
          end
        end

        def self.get_children(client, parent)
          client.all(:type => nil, :q => "_parent:#{parent}",:routing => parent)
        end

        def self.get_doc(client, parent, doc)
          client.extract_hits(
            client.search(:type => nil, :q => "_id:#{doc}", :routing => parent)
          )
        end
      end

      # Transplants a document from one parent to another by deleting the old
      # one and reindexing it with a new parent. If no doc is given, all
      # documents of the old parent will be transplanted.
      # 
      # To change the index and parent type this command operates on, 
      # use Client#with:
      #   
      #   client.with :index => "foo", :type => "blog" do |c|
      #     c.transplant(1, 2, 3)
      #   end
      # 
      # Transplant does not refresh automatically.
      # 
      # @param [String, Hash, Object#id] old_parent the old parent document,
      #         either as an Object from which the ID can be retrieved.
      # @param [String, Hash, Object#id] new_parent the new parent document,
      #         either as an Object from which the ID can be retrieved.
      # @param [String, Hash, #id, #to_h] doc the document to transplant,
      #         either as an Object from which the ID can be retrieved.
      def transplant(old_parent, new_parent, doc = nil)
        old_pid, new_pid, doc_id = Functions.extract_ids(old_parent, new_parent, doc)

        if doc.nil?
          hits = Functions.get_children(self, old_pid)
        else
          hits = Functions.get_doc(self, old_pid, doc)
        end

        unless hits.empty?
          bulk do |b|
            hits.each do |hit|
              b.delete :type => hit["_type"],
                       :id => hit["_id"],
                       :routing => old_pid
              b.index  :type => hit["_type"],
                       :id => hit["_id"],
                       :parent => new_pid,
                       :doc => hit["_source"]
            end
          end
        end
      end

      # Like #transplant, but removes the old parent.
      # 
      # @param [String, Hash, Object#id] old_parent the old parent document,
      #         either as an Object from which the ID can be retrieved.
      # @param [String, Hash, Object#id] new_parent the new parent document,
      #         either as an Object from which the ID can be retrieved.
      def merge_parents(old_parent, new_parent)
        transplant(old_parent, new_parent)
        delete(:id => old_parent)
      end
    end
  end
end

Eson::Client.class_eval {
  include Eson::More::Transplant
}