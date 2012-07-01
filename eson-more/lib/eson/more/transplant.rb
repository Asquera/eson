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

        def self.get_docs(old_parent)
          client.all(:q => "_parent:#{old_pid}")
        end
      end

      # Transplants a document from one parent to another by deleting the old
      # one and reindexing it with a new parent. If no doc is given, all
      # documents of the old parent will be transplanted.
      # 
      # @param [String, Hash, Object#id] old_parent the old parent document,
      #         either as an Object from which the ID can be retrieved.
      # @param [String, Hash, Object#id] new_parent the new parent document,
      #         either as an Object from which the ID can be retrieved.
      # @param [String, Hash, Object#<id,to_h>] doc the document to transplant,
      #         either as an Object from which the ID can be retrieved.
      def transplant(old_parent, new_parent, doc = nil)
        old_pid, new_pid, doc_id = Functions.extract_ids(old_parent, new_parent, doc)

        if doc.nil?
          docs = Functions.get_children(old_pid)
        else
          docs = Array(Functions.get_doc(old_parent, doc))
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
      end
    end
  end
end