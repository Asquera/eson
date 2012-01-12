# echolon-search: The elasticsearch query DSL, in Ruby

This gem provides a full implementation of the elasticsearch query DSL, independent of a client.

Features:

* Safe: it does its best to avoid generating improper queries
* Close to the original: All queries and filters have the same name as in the elasticsearch documentation
* Ease of use: makes handing some of the trickier aspects of the query language easier
* Complete: Incorporates all of the elasticsearch query language
* Fast

## Usage

``` ruby
require 'echolon-search'
require 'json'

q = ElasticSearch::Search::BaseQuery.new do
  query do
    match_all
  end
  filters do
    range :age, :from => 10, :to => 20
  end
  facets do
    histogram :hist1, :field => :age, :interval => 2
  end
end

JSON.dump(q.to_query_hash)
```

This example yields:

```json
{
  "query": {
    "filtered": {
      "query": {
        "match_all": { }
      },
      "filter": {
        "range": {
          "age": {
            "from": 10,
            "to": 20
          }
        }
      }
    }
  },
  "facets": {
    "hist1": {
      "histogram": {
        "field": "age",
        "interval": 2
      }
    }
  }
}
```

The query generator does its best to avoid extra work. For example, if filtering is all you want, you can omit the query part - a `filtered` query with a `match_all`-query will be generated automatically:

```ruby
q.filter do
  term "foo", :value => 'bar'
end
```

will generate:

```ruby
{
  "query": {
    "filtered": {
      "query": {
        "match_all": { }
      },
      "filter": {
        "term": {
          "foo": {
            "value": "bar"
          }
        }
      }
    }
  }
}
```

## Caveants

`and` and `or` are Ruby keywords and can only be used as methods of the receiver is explicit. For that reason, you need to write the following to generate `and`- and `or`-filters:

```ruby
q.filter do |f|
  f.and do #and is a keyword, so it needs a receiver
    range :post_date, {:from => "2010-03-01", :to => "2010-04-01"}
    prefix "name.second" => "ba"
  end
end
```

and

```ruby
q.filter do |f|
  f.or do
    term "name.first" => "Felix"
    term "name.first" => "Florian"
  end
end
```

## TODOs

At the moment, the following features are missing:

* facet_filter
* facet scopes
* geo queries