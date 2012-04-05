Eson::Search::BaseQuery.new do
  query do
    term "user", :value => "kimchy", :boost => 2.0
  end
end
