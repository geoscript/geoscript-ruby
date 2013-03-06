# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'geoscript/version'

Gem::Specification.new do |gem|
  gem.name = 'geoscript'
  gem.version = GeoScript::VERSION
  gem.summary = 'GeoScript is a library for making use of GeoTools from JRuby easier and more fun.'
  gem.description = 'GeoScript for JRuby - makes using GeoTools from JRuby easier and more fun.'
  gem.platform = 'java'
  gem.licenses = ['MIT']

  gem.authors = ['Scooter Wadsworth']
  gem.email = ['scooterwadsworth@gmail.com']
  gem.homepage = 'https://github.com/scooterw/geoscript-ruby'

  gem.files = Dir['README.md', 'lib/**/*', 'spec/support/**/*']
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard-rspec'
end
