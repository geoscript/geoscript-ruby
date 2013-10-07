jars_path = File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'geotools-libs')

Dir.entries(jars_path).sort.each do |entry|
  $CLASSPATH << File.join(jars_path, entry) if entry =~ /.jar$/
end

java_import org.geotools.factory.Hints

unless java.lang.System.get_property("org.geotools.referencing.forceXY") == 'true'
  java.lang.System.set_property 'org.geotools.referencing.forceXY', 'true'
end

Hints.put_system_default Hints::FORCE_LONGITUDE_FIRST_AXIS_ORDER, java.lang.Boolean.new(true)

module GeoScript
  GEOTOOLS_VERSION = '10.0'
end
