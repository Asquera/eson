require './test/test_config'

context 'HTTP client quick api' do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    ElasticSearch::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                              :protocol => ElasticSearch::HTTP, 
                              :plugins => [ElasticSearch::QueryPlugin, ElasticSearch::StatusHandler, ElasticSearch::ResponseParser], 
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
                   :id => 600
      end
      
      asserts("id") { topic["_id"] }.equals("600")
    end
    
    context "delete" do
      setup do
        client.delete :type => "bar", 
                      :id => 600
      end
      
      asserts("ok") { topic["ok"] }
    end
    
  end
  
  context "percolate" do
    setup do
      begin
        client.create_index :index => 'test'
        client.percolate :index => 'test',
                         :type => 'kuku',
                         :query => {
                           :match_all => { }
                         }
      rescue Exception => e
        pry e
      end
      client.refresh
    end
    
    asserts("ok") { topic["ok"] }
    asserts("responds to percolation requests") do
      (
        client.percolate :index => 'test',
                                    :type => "type1",
                                    :doc => {
                                      :test => "foo"
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