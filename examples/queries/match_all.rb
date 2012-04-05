Eson::Search::BaseQuery.new do
  query do
    match_all :boost => 2.0
  end
end