Eson::Search::BaseQuery.new do
  query do
    wildcard "user" => "kim*y"
  end
end