# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lockitron/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = "lockitron"
  gem.homepage = "http://github.com/jarred-sumner/lockitron"
  gem.license = "MIT"
  gem.summary = %Q{Lock and unlock your lock your Lockitron-powered locks from bash and Ruby}
  gem.description = %Q{Lockitron lets you unlock your front door from anywhere in the world, including your smartphone. We have an iPhone app, an Android app, a webapp, a mobile web app, a REST API, and now, a RubyGem.}
  gem.email = "jarred@lockitron.com"
  gem.authors = ["Jarred Sumner"]
  gem.add_dependency 'rest-client'
  gem.add_dependency 'thor'
  gem.add_dependency 'json'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
  gem.version       = Lockitron::VERSION
end
