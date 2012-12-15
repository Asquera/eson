require './test/test_config'

context 'HTTP client' do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    Eson::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                              :protocol => Eson::HTTP, 
                              :plugins => [Eson::StatusHandler, Eson::ResponseParser], 
                              :logger => 'test/test.log',
                              :auth => ['Aladdin', 'open sesame'])
  end
  
  context "http auth" do
    asserts {
      request = client.search({}, false)
      request.base_resource.headers['Authorization']
    }.equals('Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==')
  end
  
  context "missing index" do
    asserts {
      client.refresh
      client.get :index => "missing", :type => "foo", :id => 1
    }.raises(Eson::IndexNotFoundError)
  end
  
  context "missing handler" do
    asserts {
       client.get :index => "missing"
    }.raises(Eson::Error)
  end
  
  # deactivated, because it is behaving flakey...
  #context "with an existing index" do
  #  setup do
  #    client.create_index :index => "existing"
  #    client.refresh
  #  end
  #  
  #  asserts {
  #    client.get :index => "existing", :type => "foo", :id => 81923123
  #  }.raises(Eson::NotFoundError)
  #end
  
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
      result = client.put_template :name => 'foo',
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
      sleep 0.5
      result
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
      client.create_index :index => "ghi"
      client.create_index :index => "jkl"
      client.aliases do |r|
        r.add "abc", "alias"
        r.add "def", "alias"
        r.add "ghi", "alias", :routing => 1
        r.add "jkl", "alias", :filter => { "term" => { "user" => "kimchy" } }
      end
    end
    
    asserts("ok") { topic["ok"] }
    asserts("can be queried") do
      client.status :index => "alias"
    end
    asserts("can be retrieved") do
      client.get_aliases
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
      client.refresh
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
      result = client.put_mapping :index => 'mappings',
                         :type => 'type1',
                         :mapping => {
                           :type1 => {
                             :_source => { :enabled => false },
                             :properties => {
                               :field1 => { :type => "string", :index => "not_analyzed" }
                             }
                           }
                         }
      sleep 0.5
      result
    end
    
    asserts("ok") { topic["ok"] }
    asserts("mapping can be retrieved") do
      (
        client.get_mapping :index => "mappings", 
                           :type => 'type1'
      )['type1']['_source']['enabled']
    end.equals(false)
  end
  
  context "exists?" do
    denies { client.exists? :index => 'does_not_exist_at_all' }
  end
  
  context "index stats" do
    setup do
      client.index_stats :index => 'default'
    end

    asserts { topic["ok"] }.equals(true)
  end
  
  context "index segments" do
    setup do
      client.segments :index => 'default'
    end
  
    asserts { topic["ok"] }.equals(true)
  end

end
