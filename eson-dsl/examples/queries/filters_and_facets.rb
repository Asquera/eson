Eson::Search::BaseQuery.new do
  query do
    match_all
  end
  filters do
    range :age, :from => 10, :to => 20
  end
  facets do
    histogram :hist1, :field => :age, :interval => 2
  end
end
