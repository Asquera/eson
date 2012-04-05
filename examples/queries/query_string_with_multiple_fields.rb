Eson::Search::BaseQuery.new do
  query do
    query_string :fields => ["content", "name^5"],
                 :query => "this AND that OR thus",
                 :use_dis_max => true
  end
end
