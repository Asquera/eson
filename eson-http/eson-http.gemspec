# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
#require "./lib/elsearch"

Gem::Specification.new do |s|
  s.name        = "eson-http"
  s.version     = "0.8.0"

  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Florian Gilcher"]
  s.email       = ["florian.gilcher@asquera.de"]
  s.homepage    = ""
  s.summary     = %q{A modular client for Eson - HTTP interface}
  s.description = %q{A modular client for Eson. It provides
  an implementation of the Query language as well as multiple client implementations
  for HTTP and native access.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  #s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  #s.add_dependency "typhoeus"
  s.add_dependency "faraday", "~> 0.8.0"
  s.add_dependency "net-http-persistent"
  s.add_dependency "addressable"
  s.add_dependency "eson-core"
  s.add_development_dependency "elasticsearch-node"
  s.add_development_dependency "riot"
end
