# basically, this is also a test for the bulk interface :)

node = Node::External.instance

c = Eson::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                              :protocol => Eson::HTTP, 
                              :plugins => [Eson::ResponseParser], 
                              :logger => 'test/test.log')

c.delete_index :index => "_all" rescue nil


c.bulk do |bulk_request|
  1.upto(500) do |i|
    bulk_request.index :index => "default",
                       :type => "bar",
                       :doc => {"foo" => "bar"}
  end
end

c.create_index :index => "for_deletion" 
c.delete_index :index => "for_creation" rescue nil
c.delete_index :index => "for_creation_with_settings_and_mappings" rescue nil
c.delete_index :index => "abc" rescue nil
c.delete_index :index => "def" rescue nil

c.open_index :index => "for_closing" rescue nil
c.delete_index :index => "for_closing" rescue nil
c.delete_index :index => "for_reopening" rescue nil
c.delete_index :index => "mappings" rescue nil
