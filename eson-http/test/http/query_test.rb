require './test/test_config'

context 'HTTP client quickapi' do
  helper(:node) { Node::External.instance }

  helper(:client) do
    Eson::Client.new(:server => "http://#{node.ip}:#{node.port}",
                              :protocol => Eson::HTTP,
                              :plugins => [Eson::StatusHandler, Eson::ResponseParser],
                              :logger => 'test/test.log')
  end

  setup do
    #client.create_index :index => "default"
    client.refresh
  end

  context "query" do
    setup do
      client.query :query => {
        "term" => { "user" => "kimchy" }
      }
    end

    asserts("has hits") { topic['hits']['total'] }
    asserts("has no failures") { topic["_shards"]["failures"]}.equals(nil)
  end

  context "count query" do
    setup do 
      client.count :query => {
        :match_all => { }
      }
    end

    asserts("has hits") { topic["count"] }
    asserts("has no failures") { topic["_shards"]["failures"]}.equals(nil)
  end

  context "mlt query" do
    setup do
      client.index :doc => {"test" =>  "bar"}, 
                   :type => "bar", 
                   :id => 200

      client.more_like_this :index => 'default', :type => "bar", :id => 200
    end

    asserts("has hits") { topic["timed_out"] }.equals(false)
    asserts("has no failures") { topic["_shards"]["failures"]}.equals(nil)
  end

  context "filtered queries" do
    setup do
      client.query :query => {
                     "term" => { "name.first" => "shay" }
                   },
                   :filter => {
                     "terms" => {
                       "name.last" => ["banon", "kimchy"],
                       "_name" => "test"
                     }
                   }
    end

    asserts("ok") { topic["hits"]["total"] }.equals(0)
    asserts("has no failures") { topic["_shards"]["failures"]}.equals(nil)
  end

end
