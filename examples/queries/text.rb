Eson::Search::BaseQuery.new do
  query do
    text :type => :phrase_prefix, :message => "this is a text"
  end
end