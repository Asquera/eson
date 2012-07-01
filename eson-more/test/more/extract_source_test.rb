require './test/test_config'

context "Extract" do
  helper(:node) { Node::External.instance }
  
  helper(:client) do
    Eson::HTTP::Client.new(:server => "http://#{node.ip}:#{node.port}",
                           :logger => 'test/test.log')
  end
  
  describe "extract_sources" do
    setup do
      client.extract_sources(client.search :index => "extract_source")
    end
    
    asserts(:class).equals(Array)
    asserts(:first).equals("foo" => "bar")
  end
  
  describe "extract_hits" do
    setup do
      client.extract_hits(client.search :index => "extract_source")
    end
    
    asserts(:class).equals(Array)
    asserts("index of first element") { topic.first["_index"]}.equals("extract_source")
  end
end