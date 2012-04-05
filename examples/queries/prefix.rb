Eson::Search::BaseQuery.new do
  query do
    prefix "user", :value => "sh", :boost => 2.0
  end
end