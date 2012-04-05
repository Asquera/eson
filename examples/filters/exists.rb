Eson::Search::BaseQuery.new do
  query do
    constant_score do
      filter do
        exists :field => "user"
      end
    end
  end
end
