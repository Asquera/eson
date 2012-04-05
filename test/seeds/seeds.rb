# basically, this is also a test for the bulk interface :)

node = Node::External.instance

c = Eson::Client.new(:server => "http://#{node.ip}:#{node.port}", 
                              :protocol => Eson::HTTP, 
                              :plugins => [Eson::ResponseParser], 
                              :logger => 'test/test.log')

c.delete_index :index => "_all" rescue nil

bulk_request        = c.bulk
index_request       = c.index

index_request.index = "default"
index_request.item  = {"foo" => "bar"}
index_request.type  = "bar"

1.upto(500) do |i|
  index_request.id  = i
  
  bulk_request << index_request
end

bulk_request.call

c.create_index :index => "for_deletion" 
c.delete_index :index => "for_creation" rescue nil
c.delete_index :index => "for_creation_with_settings_and_mappings" rescue nil
c.delete_index :index => "abc" rescue nil
c.delete_index :index => "def" rescue nil

c.open_index :index => "for_closing" rescue nil
c.delete_index :index => "for_closing" rescue nil
c.delete_index :index => "for_reopening" rescue nil
c.delete_index :index => "mappings" rescue nil
