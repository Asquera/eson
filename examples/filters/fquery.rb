Eson::Search::BaseQuery.new do
  query do
    constant_score do
      filter do
        fquery :_cache => true do
          query_string "this AND that OR thus"
        end
      end
    end
  end
end
