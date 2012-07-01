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

c.create_index :index => "transplant"
c.put_mapping :index => "transplant",
              :type => 'blog',
              :mapping => {
                :blog => {
                  :properties => {
                    :foo => { :type => "string", :index => "not_analyzed" }
                  }
                }
              }

c.put_mapping :index => "transplant",
              :type => 'blog_tag',
              :mapping => {
                :blog_tag => {
                  :_parent => { :type => "blog" }
                }
              }

c.index :index => "transplant",
        :type => :blog,
        :id => 1,
        :doc => {:foo => "bar"}
c.index :index => "transplant",
        :type => :blog,
        :id => 2,
        :doc => {:foo => "bar"}

c.refresh :index => "transplant"

c.bulk do |bulk_request|
  3.upto(500) do |i|
    bulk_request.index :index  => "transplant",
                       :type   => "blog_tag",
                       :id     => i,
                       :doc    => {"foo" => "bar"},
                       :parent => ((i % 2) + 1)
  end
end

c.refresh(:index => "all")
c.refresh(:index => "transplant")
c.refresh(:index => "extract_source")