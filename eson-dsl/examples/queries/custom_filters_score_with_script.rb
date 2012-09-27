Eson::Search::BaseQuery.new do
  query do
    custom_filters_score :score_mode => :first, :script => "3" do
      query { match_all }
      filters do
        filter do
          range :age, :from => 0 , :to => 10
        end
        filter do
          range :age, :from => 10, :to => 20
        end
      end
    end
  end
end