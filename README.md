# Eson - a bare metal client for ElasticSearch in Ruby

Eson is an ElasticSearch client for everyone that wants to use the full power of ElasticSearch, but doesn't care about integrations. Eson implements the full ElasticSearch API and provides a complete generator for the ElasticSearch query DSL. It is implemented in multiple subprojects which can be used independently.

## eson

Eson is a metagem and depends on and requires `eson-core`, `eson-http` and `eson-dsl`, which should be the most common requirement. Use it to get started.

## eson-dsl

`eson-dsl` is a Ruby library for generating the ElasticSearch query DSL. It is complete and implements the full DSL. See `eson-dsl/README.md` for details. `eson-dsl` can be used standalone.

## eson-core

`eson-core` provides base modules for implementing a ElasticSearch client. It does not care about the protocol in use, but does describe which parameters are used by which request.

## eson-http

`eson-http` implements the HTTP interface of elasticsearch. Optionally, it can be integrated with `eson-dsl`. See `eson-http/README.md` for details. 

## eson-native

(unreleased, coming soon) `eson-native` implements a client using the elasticsearchs Java client.