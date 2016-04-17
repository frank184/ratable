$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ratable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ratable"
  s.version     = Ratable::VERSION
  s.authors     = ["="]
  s.email       = ["="]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Ratable."
  s.description = "TODO: Description of Ratable."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_development_dependency "rspec"
end
