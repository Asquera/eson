Eson::Search::BaseQuery.new do
  query do
    flt_field "name.first",
              :like_text => "text like this one",
              :max_query_terms => 12
  end
end
