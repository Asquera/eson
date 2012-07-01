require './test/test_config'

context "HTTP client" do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    Eson::HTTP::Client.new(:server => "http://#{node.ip}:#{node.port}",
                           :logger => 'test/test.log',
                           :auto_call => false)
  end
  
  asserts("too many params") { client.index.parameters = {:foo => :bar} }.raises(NoMethodError)
  
  asserts("#with allows parameter change") {
    req = client.with :index => :foo do |other_client|
      other_client.search :q => "*"
    end
    
    req.index
  }.equals(:foo)
end