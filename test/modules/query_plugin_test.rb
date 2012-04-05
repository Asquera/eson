require './test/test_config'

context "QueryPlugin" do
#  helper(:node) { Node::External.instance }
#  
#  helper(:client) do
#    Eson::Client.new(:server => "http://#{node.ip}:#{node.port}", 
#                              :protocol => Eson::HTTP, 
#                              :plugins => [Eson::QueryPlugin, Eson::ResponseParser], 
#                              :logger => 'test/test.log')
#  end
#  
#  setup do
#    client.create_index :index => "default"
#    client.refresh
#    client.search do |search|
#      search.query {
#        query {
#          match_all
#        }
#      }
#    end
#  end
#  
#  asserts("has hits") { topic["hits"] }
end
