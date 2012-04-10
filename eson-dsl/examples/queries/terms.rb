Eson::Search::BaseQuery.new do
  query do
    terms({:tags => ['blue', 'pill'], :minimum_match => 2})
  end
end