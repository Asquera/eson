# eson-dsl: The elasticsearch query DSL, in Ruby

[![Build Status](https://secure.travis-ci.org/Asquera/eson-dsl.png?branch=master)](http://travis-ci.org/Asquera/eson-dsl)

This gem provides a full implementation of the ElasticSearch query DSL, independent of a client. At the moment, it encodes the query DSL of ElasticSearch 0.19

Features:

* Safe: it does its best to avoid generating improper queries
* Close to the original: All queries and filters have the same name an similar parameter order as in the elasticsearch documentation
* Ease of use: makes handing some of the trickier aspects of the query language easier
* Complete: Incorporates all of the elasticsearch query language

## Usage

``` ruby
require 'eson-dsl'
require 'json'

q = Eson::Search::BaseQuery.new do
  query do
    wildcard :user, :value => "kim*y", :boost => 2.0
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
        "wildcard": {
          "user": {
            "value": "kim*y",
            "boost": 2.0}
          }
        }
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

## Parameters

Parameters can be passed to BaseQuery to allow generation of dynamic queries, without playing with variable visibility:

```ruby
Eson::Search::BaseQuery.new(:search_string => "kim*y", :boost => 2.0) do
  query do
    wildcard :user, :value => param(:search_string), :boost => param(:boost)
  end
end

```

## Examples

See `examples` for all examples used in the test suite.

## Specialities

Eson supports scoped facets in an object-oriented way. To scope a facet, call `scope` on it and pass the reference to a subquery. In practice, this requires a bit of trickery in Ruby 1.9, as it local variables are not propagated outside of the introducing block:

```ruby
Eson::Search::BaseQuery.new do
  q = nil
  query do
    q = nested :path => :obj1, :score_mode => "avg" do
      query do
        match_all
      end
      filters do
        range :age, :from => 10, :to => 20
      end
    end
  end

  facets do
    (histogram :hist1, :field => :age, :interval => 2).scope(q, 'my_scope')
  end
end
```

## Caveats

`and`, `not` and `or` are Ruby keywords and can only be used as methods of the receiver is explicit. For that reason, you need to write the following to generate `and`- and `or`-filters:

```ruby
q.filter do |f|
  f.or do
    term "name.first" => "Felix"
    term "name.first" => "Florian"
  end
end
```

and

```ruby
q.filter do |f|
  f.and do #and is a keyword, so it needs a receiver
    range :post_date, {:from => "2010-03-01", :to => "2010-04-01"}
    prefix "name.second" => "ba"
  end
end
```

Due to clever defaults, `and` can be omitted altogether:

```ruby
q.filter do |f|
  range :post_date, {:from => "2010-03-01", :to => "2010-04-01"}
  prefix "name.second" => "ba"
end
```


# TODO

* Indices-Query is missing
* Custom-Boost-Query is missing)
* More docs
* Testing on Ruby 1.8
