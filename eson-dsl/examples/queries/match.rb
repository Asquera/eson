# Since 0.19.9, #match replaces the #text query. Prefer #match over #text in 
# any case.
Eson::Search::BaseQuery.new do
  query do
    match :type => :phrase_prefix, :message => "this is a text"
  end
end