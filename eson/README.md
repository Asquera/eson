# Eson - a bare metal client for ElasticSearch in Ruby

`eson` is a meta-gem that provides the most common configuration: `eson-http` and `eson-dsl`, together with a default client. If you just want to get started, just install an use `eson`:

```
gem install eson
```

```ruby
require 'eson'

c = Eson::HTTP::Client.new
c.search do
  query {
    match_all
  }
end
```