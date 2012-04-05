Eson::Search::BaseQuery.new do
  query do
    match_all
  end
  filter do
    ids "user", [1,2,3,4,5,6,7]
  end
end
