require './test/test_config'
require 'eson-dsl'

context "QueryPlugin" do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    Eson::HTTP::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                           :logger => 'test/test.log')
  end
  
  setup do
    client.create_index :index => "default" rescue nil
    client.refresh
  end
  
  context "#search" do
    setup do
      client.search do
        query {
          match_all
        }
      end
    end
  
    asserts("has hits") { topic["hits"] }
  end
  
  context "#delete_by_query" do
    setup do
      client.delete_by_query :query => { :query => { :match_all => {} } }
    end
    
    asserts("ok"){ topic["ok"] }.equals(true)
  end
end
