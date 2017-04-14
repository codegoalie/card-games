$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "cards/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cards"
  s.version     = Cards::VERSION
  s.authors     = 'Chris Marshall'
  s.email       = 'chris@chrismar035.com'
  s.homepage    = "https://github.com/chrismar035/cards"
  s.summary     = "Generic playing card library"
  s.description = "Library of base classes to build playing card based games"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["APACHE-LICENSE", "Rakefile", "README.md"]
  s.require_path = 'lib'

  s.add_dependency 'activesupport/inflector'

  s.add_development_dependency "rspec"
  s.add_development_dependency "codeclimate-test-reporter"
end
