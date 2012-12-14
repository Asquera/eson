# Since 0.19.9, #match replaces the #text query. Prefer #match over #text in 
# any case.
Eson::Search::BaseQuery.new do
  query do
    match "message", :type => :phrase_prefix, :query => "this is a text"
  end
end