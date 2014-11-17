# eson-core

Core classes for implementing an ElasticSearch client.

This is a meta-gem that provides a definition of the whole ElasticSearch API (parameter values, required parameters, etc.). It also provides a client class for working with these definitions.


## Generate templates

There is a command line tool to generate a Ruby class from an API description (JSON) for use with the eson gem. The idea is to use the official API documentation folder and to generate all necessary classes from there for use with the eson lib. In this way API updates can be easier updated and differences between API version might be easier to observe.

For now a single API description JSON file can be transformed into a Ruby description.

```
$ ruby -Ilib bin/generator.rb generate --input=cluster.state.json --output=cluster.state.rb
```

this reads the file `cluster.state.json` and generates a Ruby file named `cluster.state.rb`.