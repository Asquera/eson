Eson::Search::BaseQuery.new do
  facets do
    range :range1, :age, { :to => 50 },
                         { :from => 20, :to => 70 },
                         { :from => 70, :to => 120 },
                         { :from => 150 }
  end
end