# Eson - the meta-gem

`eson` is a meta-gem that provides the most common configuration: `eson-http` and `eson-dsl`, together with a default client. If you just want to get started, just install an use `eson`:

    gem install eson

And start working:

    require 'eson'
    
    c = Eson::HTTP::Client.new.with(:index => "my_index")
    c.search do
      query {
        match_all
      }
    end
    