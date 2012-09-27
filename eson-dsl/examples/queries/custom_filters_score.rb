Eson::Search::BaseQuery.new do
  query do
    custom_filters_score :score_mode => :first do
      query { match_all }
      filters do
        filter(:boost => 3) do
          range :age, :from => 0 , :to => 10
        end
        filter(:boost => 2) do
          range :age, :from => 10, :to => 20
        end
      end
    end
  end
end