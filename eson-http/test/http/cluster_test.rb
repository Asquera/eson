require './test/test_config'

context 'HTTP client cluster api' do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    Eson::HTTP::Client.new(:server => "http://#{node.ip}:#{node.port}",
                           :logger => 'test/test.log')
  end
    
  context "cluster health" do
    setup do
      client.health
    end
    
    asserts("returns cluster info") { topic["cluster_name"]}.equals("eson-test")
  end
  
  context "cluster state" do
    setup do
      client.state
    end
    
    asserts("returns metadata") { topic["metadata"] }
  end
  
  context "cluster state with filtered metadata" do
    setup do
      client.state :filter_metadata => true
    end
    
    asserts("metadata") { topic["metadata"] }.equals(nil)
  end
  
  context "cluster nodes info" do
    setup do
      client.nodes
    end
    
    asserts("returns nodes info") { topic["nodes"] }
  end
  
  context "filtered cluster nodes" do
    setup do
      client.nodes :nodes => "non_existant_node"
    end
    
    asserts("returns no nodes info") { topic["nodes"] }.empty
  end
  
  context "stats" do
    setup do
      client.stats
    end
    
    asserts("returns nodes info") { topic["nodes"] }
  end
end
