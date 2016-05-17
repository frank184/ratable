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
  s.summary     = "A simple RoR gem that provides a lightweight framework for building a rating systems and includes the JQuery Raty library from https://github.com/wbotelhos/raty."
  s.description = "A simple RoR gem that provides a lightweight framework for building a rating systems and includes the JQuery Raty library from https://github.com/wbotelhos/raty."
  s.license     = 'MIT'

  s.post_install_message = %{Feel free to contribute! https://www.github.com/frank184/ratable}

  s.files = Dir['{app,config,db,lib,vendor}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency('rails')
  s.add_dependency('jquery-rails')

  s.add_development_dependency('mysql2') # Or whatever you want
  s.add_development_dependency('devise')
  s.add_development_dependency('rspec-rails')
  s.add_development_dependency('shoulda-matchers')
  s.add_development_dependency('factory_girl_rails')
  s.test_files = Dir["spec/**/*"]
end
