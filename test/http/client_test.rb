require './test/test_config'

context "HTTP client" do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    Eson::HTTP::Client.new(:server => "http://#{node.ip}:#{node.port}",
                           :logger => 'test/test.log',
                           :auto_call => false)
  end
  
  asserts("too many params") { client.index.params = {:foo => :bar} }.raises(NoMethodError)

end