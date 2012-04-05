Eson::Search::BaseQuery.new do
  query do
    flt :fields => ["name.first", "name.last"],
        :like_text => "text like this one",
        :max_query_terms => 12
  end
end
