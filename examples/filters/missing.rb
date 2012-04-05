Eson::Search::BaseQuery.new do
  query do
    constant_score do
      filter do
        missing :field => "user"
      end
    end
  end
end