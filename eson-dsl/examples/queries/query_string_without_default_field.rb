Eson::Search::BaseQuery.new do
  query do
    query_string "this AND that OR thus"
  end
end
