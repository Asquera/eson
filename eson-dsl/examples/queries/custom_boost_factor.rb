Eson::Search::BaseQuery.new do
  query do
    custom_boost_factor :boost_factor => 5 do
      query do
        term "tag" => "wow"
      end
    end
  end
end