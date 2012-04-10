Eson::Search::BaseQuery.new do
  query do
    fuzzy :user => "ki"
  end
end
