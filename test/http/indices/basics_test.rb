require './test/test_config'

context 'HTTP client indices API' do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    ElasticSearch::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                              :protocol => ElasticSearch::HTTP, 
                              :plugins => [ElasticSearch::QueryPlugin, ElasticSearch::StatusHandler], 
                              :logger => 'test/test.log')
  end
  
  context "missing index" do
    asserts {
      client.get :index => "missing", :type => "foo", :id => 1
    }.raises(ElasticSearch::Error)
  end
  
  context "missing handler" do
    asserts {
       client.get :index => "missing"
    }.raises(ElasticSearch::Error)
  end
  
  context "delete index" do
    setup do
      client.delete_index :index => "for_deletion"
    end
    
    asserts("ok") { topic["ok"] }
  end
  
  context "create index" do
    setup do
      client.create_index :index => "for_creation"
    end
    
    asserts("ok") { topic["ok"] }
  end
  
  context "create with settings and mappings" do
    setup do
      client.create_index :index => "for_creation_with_settings_and_mappings",
                          :settings => {
                            :index => {
                              :number_of_shards => 1
                            }
                          },
                          :mappings => {
                            :type1 => {
                              :_source => { :enabled => false },
                              :properties => {
                                :field1 => { :type => "string", :index => "not_analyzed" }
                              }
                            }
                          }
    end
    
    asserts("ok") { topic["ok"] }
    asserts("settings can be retrieved") do
      (
        client.get_settings :index => "for_creation_with_settings_and_mappings"
      )["for_creation_with_settings_and_mappings"]["settings"]["index.number_of_shards"]
    end
  end
  
  context "template creation" do
    setup do
      client.put_template :name => 'foo',
                          :template => 'foo*',
                          :settings => {
                            :index => {
                              :number_of_shards => 1
                            }
                          },
                          :mappings => {
                            :type1 => {
                              :_source => { :enabled => false },
                              :properties => {
                                :field1 => { :type => "string", :index => "not_analyzed" }
                              }
                            }
                          }
    end
    
    asserts("ok") { topic["ok"] }
    
    context "get template" do
      setup do
        client.get_template :name => 'foo'
      end
      
      asserts("returns correct template") { topic["foo"] }
    end
    
    context "delete template" do
      setup do
        client.delete_template :name => 'foo'
      end
      
      asserts("ok") { topic["ok"] }
    end
  end
  
  context "aliases" do
    setup do
      client.create_index :index => "abc"
      client.create_index :index => "def"
      client.aliases do |r|
        r.add "abc", "alias"
        r.add "def", "alias"
      end
    end
    
    asserts("ok") { topic["ok"] }
    asserts("can be queried") do
      client.status :index => "alias"
    end    
  end
  
  context "refresh" do
    setup do
      client.refresh :index => "default"
    end
    
    asserts("ok") { topic["ok"] }
  end
  
  context "snapshot" do
    setup do
      client.snapshot :index => "default"
    end
    
    asserts("ok") { topic["ok"] }
  end
  
  context "clear_cache" do
    setup do
      client.clear_cache :index => "default",
                         :filter => true
    end
    
    asserts("ok") { topic["ok"] }
  end
  
  context "flush" do
    setup do
      client.flush :index => "default"
    end
    
    asserts("ok") { topic["ok"] }
  end
  
  context "optimize" do
    setup do
      client.optimize :index => "default"
    end
    
    asserts("ok") { topic["ok"] }
  end
  
  context "close index" do
    setup do
      client.create_index :index => 'for_closing'
      client.close_index :index => 'for_closing'
    end
    
    asserts("ok") { topic["ok"] }
    asserts("cannot be requested") { (client.status :index => 'for_closing')["indices"] }.equals({})
  end
  
  context "open index" do
    setup do
      client.create_index :index => 'for_reopening'
      client.close_index :index => 'for_reopening'
      client.open_index :index => 'for_reopening'
    end
    
    asserts("ok") { topic["ok"] }
    asserts("can be requested") { (client.status :index => 'for_reopening')["indices"]['for_reopening'] }
  end
  
  context "put mapping" do
    setup do
      client.create_index :index => 'mappings'
      client.put_mapping :index => 'mappings',
                         :type => 'type1',
                         :mapping => {
                           :type1 => {
                             :_source => { :enabled => false },
                             :properties => {
                               :field1 => { :type => "string", :index => "not_analyzed" }
                             }
                           }
                         }
    end
    
    asserts("ok") { topic["ok"] }
    asserts("mapping can be retrieved") do
      (
        client.get_mapping :index => "mappings", 
                           :type => 'type1'
      )['type1']['_source']['enabled']
    end.equals(false)
  end
  
end
