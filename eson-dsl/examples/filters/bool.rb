Eson::Search::BaseQuery.new do 
  filter do
    bool do
      must do
        term "user" => "kimchy"
      end
      must_not do
        range :age, :from => 10, :to => 20
      end
      should do
        term "tag" => "wow"
        term "tag" => "elasticsearch"
      end
    end
  end
end