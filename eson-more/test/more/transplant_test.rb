require './test/test_config'

context "Transplant" do
  helper(:node) { Node::External.instance }

  helper(:client) do
    Eson::HTTP::Client.new(:server => "http://#{node.ip}:#{node.port}",
                           :logger => 'test/test.log')
  end

  describe "transplant one document" do
    setup do
      client.with :index => "transplant" do |c|
        c.transplant(1, 2, 4)
        c.refresh
        c.get(:type => "blog_tag", :id => 4, :routing => 2)
      end
    end
    asserts(:source) { topic["_source"]}.equals({"foo" => "bar"})
  end

  describe "transplant all" do
    setup do
      client.with :index => "transplant" do |c|
        c.transplant(1,2)
        c.refresh
        c.all(:q => "_parent:2")
      end
    end
    asserts(:class).equals(Array)
    asserts(:length).equals(498)
  end

  describe "merge_parents" do
    setup do
      client.with :index => "transplant", :type => "blog" do |c|
        c.merge_parents(1,2)
        c.refresh
        c
      end
    end

    asserts("retrieving the old parent") { topic.get(:id => 1) }.raises(Eson::NotFoundError)
    asserts("count of all children of the new client") { topic.all(:type => "blog_tag", :q => "_parent:2").length }.equals(498)
  end
end