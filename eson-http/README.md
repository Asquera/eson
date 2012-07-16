# eson-http. A HTTP client for elasticsearch

Eson provides a fairly complete implementation of the elasticsearch HTTPAPI for ruby.

It tries to keep the language of the ES API as intact as possible.

## Usage

    require 'eson-http'

    c = Eson::HTTP::Client.new(:server => 'http://localhost:9200')
    
    doc = {
      :user => "kimchy",
      :post_date => "2009-11-15T14:12:12",
      :message => "trying out Elastic Search"
    }

    c.index :index    => "twitter",
            :type     => "tweet",
            :id       => 1,
            :document => doc

    c.get :type => "tweet", :id => 1 # returns the document

    c.search :q => "message:trying"

    c.count :q => "*"

## Default parameters

All parameters can be set to default values by using `#with`. `#with` returns a new client that has the default parameters set.

    require 'eson-http'

    c = Eson::HTTP::Client.new(:server => 'http://localhost:9200')
        .with(:index => "twitter", :type => "tweet")

    doc = {
      :user => "kimchy",
      :post_date => "2009-11-15T14:12:12",
      :message => "trying out Elastic Search"
    }

    c.index :id => 1, :doc => doc

    c.get :id => 1

    c.search :q => "message:trying" # this searches tweets/tweet/_search !!!

    c.cound :q => "*" # same here

`#with` also has a block form that passes the new client as a parameters:

    c.with(:index => "twitter", :type => "tweet") do |modified_client|
      modified_client.get :id => 1
    end

## Building requests by hand

The client has an additional mode that does not call elasticsearch  immediately, but returns the request object instead.

    require 'echolon/http'

    c = Eson::HTTP::Client.new(:server => 'http://localhost:9200',
                               :auto_call => false)
    
    doc = {
      :user => "kimchy",
      :post_date => "2009-11-15T14:12:12",
      :message => "trying out Elastic Search"
    }

    index_request = c.index
    index_request.index = "twitter"
    index_request.type  = "tweet"
    index_request.id    = 1
    index_request.doc   = doc

    index_request.call

    # or:

    index_request = c.index
    index_request.parameters = {
      :index => "twitter",
      :type  => "tweet"
      :id    => 1,
      :doc   => doc
    }

    # or:

    index_request = c.index :index => "twitter",
                            :type  => "tweet"
                            :id    => 1,
                            :doc   => doc

## Bulk Requests

`bulk` and `msearch` requests can be constructed by calling the respective client methods on them:


```
c.bulk do |b|
  b.index :index => "default",
          :type => "bar"
          :doc => {"foo" => "bar"}
  b.delete :index => "default",
           :id => '134'
end

c.msearch do |s|
  s.search #....
end
```

## The shell

Eson-HTTP comes with a quick-and-dirty shell, if you have pry installed:

    $ elshell 127.0.0.1:9200
    pry(#<ElasticSearch::Client:0x000001014f4078>)> node
    => "127.0.0.1:9200"

    pry(#<ElasticSearch::Client:0x000001014f4078>)> index_name
    => "twitter"

    pry(#<ElasticSearch::Client:0x000001014f4078>)> get :type => 'tweet', :id => 2
    => {"_index"=>"twitter", "_type"=>"tweet", "_id"=>"2", "_version"=>1, "_source"=>{"user"=>"kimchy", "post_date"=>"2009-11-15T14:12:12", "message"=>"You know, for Search"}}
    

## TODO

* Test suite needs to be reordered. Its the oldest part of the project and a bit messy.
* Filters in aliases are not supported

## See also

* Tire