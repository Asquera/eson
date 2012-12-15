Eson::Search::BaseQuery.new do
  query do
    filtered do
      query { match_all }
      filter { prefix "name.second" => "ba" }
    end
  end
end