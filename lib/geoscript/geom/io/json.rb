java_import org.geotools.geojson.geom.GeometryJSON

module GeoScript
  module Geom
    module IO
      def self.write_json(geom)
        GeometryJSON.new.to_string geom
      end

      def self.read_json(json)
        GeometryJSON.new.read json.to_java
      end
    end
  end
end