# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "brentano/version"

Gem::Specification.new do |s|
  s.name        = "brentano"
  s.version     = Brentano::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Roberto Thais"]
  s.email       = ["roberto.n.thais@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Classy presenters for Rails 3}
  s.description = %q{Brentano helps you present ActiveRecord collections to your controllers and avoid repetitive ORM logic}

  s.rubyforge_project = "Brentano"

  s.add_dependency "activesupport", "~> 3"
  s.add_dependency "activerecord",  "~> 3"
  s.add_dependency "railties", "~> 3"
  s.add_dependency "hashie",  ">= 0.4"

  s.add_development_dependency "rails", '3.0.7'
  s.add_development_dependency "sqlite3", "~> 1.3.3"
  s.add_development_dependency "rspec", "~> 2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
