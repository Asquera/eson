require './test/test_config'

context 'HTTP client quick api' do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    Eson::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                              :protocol => Eson::HTTP, 
                              :plugins => [Eson::StatusHandler, Eson::ResponseParser], 
                              :logger => 'test/test.log')
  end
  
  context "after put request" do
    setup do
      client.index :doc => {"test" =>  "bar"}, 
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
      client.create_index :index => 'test'
      client.percolate :index => 'test',
                       :type => 'kuku',
                       :query => {
                         :match_all => { }
                       }
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
    Eson::HTTP::Client.new(:auto_call => false)
  end
  
  context "returns request objects" do
    setup do 
      client.index
    end
    
    asserts_topic("is an Index request").kind_of?(Eson::HTTP::Index)
  end

  context "#msearch" do
    setup do
      msearch = client.msearch
      msearch.search :index => 'test',
                     :type => 'kuku',
                     :query => {
                       :match_all => { }
                     }
      msearch.search :index => 'test',
                     :query => {
                       :match_all => { }
                     }
      msearch.search :index => 'test',
                     :search_type => 'count',
                     :query => {
                       :match_all => { }
                     }
      msearch
    end

    asserts(:source).equals(<<-JSON)
{"indices":["test"],"types":["kuku"]}
{"query":{"match_all":{}}}
{"indices":["test"]}
{"query":{"match_all":{}}}
{"indices":["test"],"search_type":"count"}
{"query":{"match_all":{}}}
JSON
  end
end