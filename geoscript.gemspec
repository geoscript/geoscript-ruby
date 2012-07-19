# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'geoscript/version'

Gem::Specification.new do |gem|
  gem.name = 'geoscript-ruby'
  gem.version = GeoScript::VERSION
  gem.summary = gem.description = 'GeoScript for JRuby'
  gem.licenses = ['MIT']

  gem.authors = ['Scooter Wadsworth']
  gem.email = ['scooterwadsworth@gmail.com']
  gem.homepage = 'http://github.com/scooterw/geoscript-ruby'
  
  gem.files = Dir['README.md', 'lib/**/*', 'spec/support/**/*']
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard-rspec'
end