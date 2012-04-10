Eson::Search::BaseQuery.new do
  query do
    term :tag => "something"
  end
  filter do |f|
    f.not do
      term "name.first" => "Florian"
    end
  end
end