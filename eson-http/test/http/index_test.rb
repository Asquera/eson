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
  
  context "mget" do
    setup do
      client.create_index :index => 'mget'
      client.index :index => "mget_test",
                   :type => "foo",
                   :doc => {:foo => :bar},
                   :id => 1
      client.index :index => "mget_test",
                   :type => "foo",
                   :doc => {:foo => :bar},
                   :id => 2
      client.refresh
      client.mget(:index => "mget_test", :ids => [1,2])
    end

    asserts("number of docs") { topic["docs"].length }.equals(2)
  end

  unless ENV["ES_VERSION"] && ENV["ES_VERSION"] < "0.19.0"
    context "delete_by_query" do
      setup do
        client.index :index => "delete_by_query",
                     :type => "foo",
                     :doc => {:foo => :bar}
        client.index :index => "delete_by_query",
                     :type => "foo",
                     :doc => {:foo => :bar}
        client.refresh :index => "delete_by_query"
    
        client.delete_by_query :index => "delete_by_query",
                               :query => { :match_all => {} }
      end
    
      asserts("no doc left") { client.search(:index => "delete_by_query")["hits"]["total"] }.equals(0)
    end
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

  context "#msearch without block" do
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

  context "#msearch with block" do
    setup do
      client.msearch :index => "foo", :type => "bar" do |s|
        s.search :index => 'test',
                 :type => 'kuku',
                 :query => {
                   :match_all => { }
                 }
        s.search :index => 'test',
                 :query => {
                   :match_all => { }
                 }
        s.search :index => 'test',
                 :search_type => 'count',
                 :query => {
                   :match_all => { }
                 }
      end
    end

    asserts(:source).equals(<<-JSON)
{"indices":["test"],"types":["kuku"]}
{"query":{"match_all":{}}}
{"indices":["test"]}
{"query":{"match_all":{}}}
{"indices":["test"],"search_type":"count"}
{"query":{"match_all":{}}}
JSON

    asserts(:fill).equals(Addressable::URI.parse("foo/bar/_msearch"))
  end
end