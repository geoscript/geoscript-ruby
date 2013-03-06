$:.unshift File.expand_path('../lib', __FILE__)
require 'geoscript/version'

task :build do
  system 'gem build geoscript.gemspec'
end

task :release => :build do
  system "gem push geoscript-#{GeoScript::VERSION}.gem"
end

task :console do
  ARGV.clear
  require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'geoscript'))
  require 'irb'
  IRB.start
end
