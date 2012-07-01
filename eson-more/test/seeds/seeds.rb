# basically, this is also a test for the bulk interface :)

node = Node::External.instance

c = Eson::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                     :protocol => Eson::HTTP, 
                     :plugins => [Eson::ResponseParser], 
                     :logger => 'test/test.log')

c.delete_index :index => "_all" rescue nil

c.bulk do |bulk_request|
  1.upto(500) do |i|
    bulk_request.index :index => "extract_source",
                       :type => "bar",
                       :doc => {"foo" => "bar"}
  end
end

c.bulk do |bulk_request|
  1.upto(500) do |i|
    bulk_request.index :index => "all",
                       :type => "bar",
                       :doc => {"foo" => "bar"}
  end
end
c.refresh(:index => "extract_source")
c.refresh(:index => "all")