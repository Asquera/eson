require './test/test_config'

context 'HTTP client quick api' do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    ElasticSearch::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                              :protocol => ElasticSearch::HTTP, 
                              :plugins => [ElasticSearch::QueryPlugin, ElasticSearch::ResponseParser], 
                              :logger => 'test/test.log')
  end
  
  context "after put request" do
    setup do
      client.index :item => {"test" =>  "bar"}, 
                   :type => "bar", 
                   :id => 600
    end
    
    asserts("is stored in correct index") {topic["_index"]}.equals('default')
    
    context "get request" do
      setup do
        client.get :type => "bar", 
                   :id => 1
      end
      
      asserts("id") { topic["_id"] }.equals("1")
    end
    
    context "delete" do
      setup do
        client.delete :type => "bar", 
                      :id => 20
      end
      
      asserts("ok") { topic["ok"] }
    end
    
  end
  
  context "percolate" do
    setup do
      client.percolate :type => 'kuku',
                       :query => {
                          :query => {
                             :term => {
                                :field1 => "value1"
                             }
                          }
                       }
      client.refresh
    end
    
    asserts("ok") { topic["ok"] }
    asserts("responds to percolation requests") do
      (
          h = client.percolate :type => "type1",
                               :doc => {
                                 :field1 => "value1"
                               }
      )["matches"]
    end.equals(["kuku"])
  end
end

context 'HTTP client verbose API' do
  helper(:client) do
    ElasticSearch::Client.new(:server => "127.0.0.1:9200", 
                              :protocol => ElasticSearch::HTTP, 
                              :plugins => [ElasticSearch::QueryPlugin, ElasticSearch::ResponseParser], 
                              :logger => 'test/test.log')
  end
  
  context "returns request objects" do
    setup do 
      client.index
    end
    
    asserts_topic("is an Index request").kind_of?(ElasticSearch::HTTP::Index)
  end
end