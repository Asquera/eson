Eson::Search::BaseQuery.new do
  query do
    query_string :default_field => "content",
                 :query => "this AND that OR thus"
  end
end
