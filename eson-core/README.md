# eson-core

Core classes for implementing an ElasticSearch client.

This is a meta-gem that provides a definition of the whole ElasticSearch API (parameter values, required parameters, etc.). It also provides a client class for working with these definitions.


## Generate templates

There is CLI tool to generate ruby files for all API endpoints for use with the eson gem. The API descriptions available as JSON files exist in the Elasticsearch project.
The idea is to generate all ruby files for the eson gem in two steps. The first step is to generate all ruby files from the API descriptions to be used in `eson-core`. The official Elasticsearch project contains a folder `rest-api-docs` with all API descriptions as JSON files.
The second step is to generate HTTP request classes for use with the `eson-http` gem.
In this way updates of Elasticsearch should be easier to handle and differences between version easier to spot.
Generated files should not be modified and are planned to get extended with new functionality.

To run the CLI command to generate ruby files from the API description files (preferrably from the Elasticsearch project):

```
$ ruby -Ilib bin/generator.rb generate --input_folder=/path_to/elasticsearch/rest-api-spec/api/ --output_folder=result/ --overwrite
```

this reads the JSON files from `/path_to/elasticsearch/rest-api-spec/api/` and generates Ruby files in the output folder `./result`.
The resulting ruby file describes the API endpoint similar to the JSON Api description by using a DSL.
The files are scanned and handled in a certain way. The name of the API endpoint is used to group the resulting files accordingly, e.g. `cluster.health.json` will be transformed to `cluster/health.rb`.
The resulting ruby file describes the API endpoint similar to the JSON Api description by using a DSL.

The following commands generate all request specific files and include the appropriate API descriptions.

```
$ ruby -Ilib bin/generator.rb requests --input_folder=/path_to/elasticsearch/rest-api-spec/api/ --output_folder=http/ --overwrite
```

This should be done sparingly and is meant for bootstrapping the HTTP request files that can be extended.
