$: << File.expand_path(File.dirname(__FILE__))
$: << File.expand_path(File.join(File.dirname(__FILE__), 'geoscript'))

if defined? JRUBY_VERSION
  require 'geotools-jars'

  require 'geoscript/version'
  require 'geoscript/util'
  require 'geoscript/io'
  require 'geoscript/projection'
  require 'geoscript/geom'
  require 'geoscript/feature'
  require 'geoscript/datastore'
  require 'geoscript/workspace'
else
  abort "GeoScript requires JRuby (http://jruby.org)"
end

java_import org.geotools.factory.Hints

unless java.lang.System.get_property('org.geotools.referencing.forceXY') == 'true'
  java.lang.System.set_property 'org.geotools.referencing.forceXY', 'true'
end

Hints.put_system_default Hints::FORCE_LONGITUDE_FIRST_AXIS_ORDER, java.lang.Boolean.new(true)

module GeoScript
  class << self
    def version
      VERSION
    end

    def geotools_version
      ::Java::OrgGeotoolsFactory::GeoTools.version.to_string
    end
    alias_method :gt_version, :geotools_version
  end
end
