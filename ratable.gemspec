$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ratable/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ratable'
  s.version     = Ratable::VERSION
  s.authors     = ['François Bélanger']
  s.email       = ['frank@smartbuildingapps.com']
  s.homepage    = 'https://github.com/frank184/ratable'
  s.summary     = "A Ruby on Rails Gem that allows Models to 'has_many' ratings or 'has_one' rating."
  s.description = "A Ruby on Rails Gem that allows Models to 'has_many' ratings or 'has_one' rating."
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2.6'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'devise'

  s.add_development_dependency 'rspec-rails', '~> 3.0'
  s.add_development_dependency 'rspec-its', '~> 1.1'
  s.add_development_dependency 'rspec-collection_matchers', '~> 1.1'
  s.add_development_dependency('appraisal', '~> 1.0.0')
  s.add_development_dependency('shoulda-matchers', '~> 2')
  s.add_development_dependency('factory_girl', '~> 2.6.0')
end
