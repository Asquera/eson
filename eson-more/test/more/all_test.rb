require './test/test_config'

context "All" do
 helper(:node) { Node::External.instance }
  
  helper(:client) do
    Eson::HTTP::Client.new(:server => "http://#{node.ip}:#{node.port}",
                           :logger => 'test/test.log')
  end
  
  setup do
    client.all(:index => "all")
  end

  asserts(:class).equals(Array)
  asserts(:length).equals(500)
end