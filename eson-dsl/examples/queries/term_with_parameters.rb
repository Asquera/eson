Eson::Search::BaseQuery.new(:term_boost => 2.0, :term => "kimchy") do
  query do
    term "user", :value => param(:term), :boost => param(:term_boost)
  end
end