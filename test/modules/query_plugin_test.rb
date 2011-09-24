require './test/test_config'

context "QueryPlugin" do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    ElasticSearch::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                              :protocol => ElasticSearch::HTTP, 
                              :plugins => [ElasticSearch::QueryPlugin, ElasticSearch::ResponseParser], 
                              :logger => 'test/test.log')
  end
  
  setup do
    client.create_index :index => "default"
    client.refresh
    client.search do |search|
      search.query do |q|
        q.match_all
      end
    end
  end
  
  asserts("has hits") { topic["hits"] }
  
end
