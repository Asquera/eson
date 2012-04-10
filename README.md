# eson-http. A HTTP client for elasticsearch

Eson provides a fairly complete implementation of the elasticsearch HTTPAPI for ruby.

It tries to keep the language of the ES API as intact as possible.

## Usage

    require 'eson-http'

    c = Eson::HTTP::Client.new(:server => 'localhost:9200')
    
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

## Building requests by hand

Requests are not executed immediately when no options are given to the client.

    require 'echolon/http'

    c = Eson::HTTP::Client.new(:server => 'localhost:9200')
    
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
    index_request.params = {
      :index => "twitter",
      :type  => "tweet"
      :id    => 1,
      :doc   => doc
    }

## Bulk Requests

Bulk requests can be constructed by adding other requests to them:


```
bulk_request = c.bulk
index_request = c.index

index_request.index = "default"
index_request.doc   = {"foo" => "bar"}
index_request.type  = "bar"

bulk_request << index_request
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

* No activemodel integration (yet!)
* Test suite needs to be reordered. Its the oldest part of the project and a bit messy.
* Filters in aliases are not supported

## See also

* Tire