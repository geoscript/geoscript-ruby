$:.push File.expand_path(File.join(File.dirname(__FILE__), 'geoscript'))

require 'java'

Dir.entries(File.join(File.expand_path(File.dirname(__FILE__)), 'geotools')).sort.each do |entry|
  if entry =~ /.jar$/
    $CLASSPATH << File.join(File.expand_path(File.dirname(__FILE__)), "/geotools/#{entry}")
  end
end

require 'geoscript/version'
require 'geoscript/projection'
require 'geoscript/geom'