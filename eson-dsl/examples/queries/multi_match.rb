Eson::Search::BaseQuery.new do
  query do
    multi_match "this is a test", :fields => ["subject", "message"]
  end
end