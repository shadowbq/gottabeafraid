# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require File.expand_path('../lib/gottabeafraid/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "gottabeafraid"
  gem.version       = Gottabeafraid::VERSION
  
  gem.authors       = ["shadowbq"]
  gem.email         = ["shadowbq@gmail.com"]
  gem.description   = %q{bundle create gottabeafraid}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/shadowbq/gottabeafraid"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.require_paths = ["lib"]
  

  gem.add_dependency('mechanize', '~> 2.5')
  gem.add_dependency('highline')
  gem.add_dependency('nokogiri')
  gem.add_dependency('chronic')
  gem.add_dependency('activesupport')
  gem.add_dependency('activerecord')
  gem.add_dependency('sqlite3')
  gem.add_dependency('socksify')
  gem.add_dependency('standalone_migrations')
end
