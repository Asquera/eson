Eson::Search::BaseQuery.new do
  query do
    field "name.first" => "+something -else"
  end
end