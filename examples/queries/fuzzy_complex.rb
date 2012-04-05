Eson::Search::BaseQuery.new do
  query do
    fuzzy :user, :value => "ki", :boost => 1.0
  end
end