# echolon-search: The elasticsearch query DSL, in Ruby

This gem provides a full implementation of the elasticsearch query DSL, independent of a client.

Features:

* Safe: it does its best to avoid generating improper queries
* Close to the original: All queries and filters have the same name as in the elasticsearch documentation
* Ease of use: makes handing some of the trickier aspects of the query language easier
* Complete: Incorporates all of the elasticsearch query language
* Fast

## Usage

```ruby
    q = ElasticSearch::Search::BaseQuery.new
    q.query do
      match_all
    end
    q.filters do
      range :age, :from => 10, :to => 20
    end
    q.facets do
      histogram :hist1, :field => :age, :interval => 2
    end
    
    q.to_query_hash
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
## Caveants 