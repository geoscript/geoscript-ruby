$: << File.expand_path(File.dirname(__FILE__))
$: << File.expand_path(File.join(File.dirname(__FILE__), 'geoscript'))

if defined? JRUBY_VERSION
  require 'java'
  require 'geoscript/jars'

  require 'geoscript/version'
  require 'geoscript/util'
  require 'geoscript/io'
  require 'geoscript/projection'
  require 'geoscript/geom'
  require 'geoscript/feature'
  require 'geoscript/datastore'
  require 'geoscript/workspace'
else
  warn "GeoScript requires JRuby (http://jruby.org)"
end

module GeoScript
  class << self
    def version
      VERSION
    end

    def geotools_version
      GEOTOOLS_VERSION
    end
    alias_method :gt_version, :geotools_version
  end
end
