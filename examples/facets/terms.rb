Eson::Search::BaseQuery.new do
  query do
    match_all
  end
  facets do
    terms :tags, :field => :tags, :size => 10, :order => :term
  end
end
