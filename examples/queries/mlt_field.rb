Eson::Search::BaseQuery.new do
  query do
    mlt_field "name.first",
              :like_text => "text like this one",
              :max_query_terms => 12
  end
end
