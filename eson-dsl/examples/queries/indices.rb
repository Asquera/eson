Eson::Search::BaseQuery.new do
  query do
    indices :index1, :index2 do
      query do
        term "tag" => "wow"
      end
      no_match_query do
        term "tag" => "kow"
      end
    end
  end
end