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
  s.summary     = %q{Presentation for the masses.}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "brentano"
  
  s.add_dependency "activesupport", "~> 3.0"
  s.add_dependency "activerecord",  "~> 3.0"
  s.add_dependency "actionpack",  "~> 3.0"
  s.add_dependency "hashie",  "~> 0.4"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
