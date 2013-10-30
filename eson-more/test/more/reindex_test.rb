require './test/test_config'

context "Reindex" do
  helper(:node) { Node::External.instance }

  helper(:client) do
    Eson::HTTP::Client.new(:server => "http://#{node.ip}:#{node.port}",
                           :logger => 'test/test.log')
  end

  setup do
    client.reindex("all", "to_all")
    client.refresh(:index => "to_all")
    client.all(:index => "to_all")
  end

  asserts(:class).equals(Array)
  asserts(:length).equals(500)
end