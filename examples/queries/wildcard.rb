Eson::Search::BaseQuery.new do
  query do
    wildcard "user", :value => "kim*y", :boost => 2.0
  end
end
