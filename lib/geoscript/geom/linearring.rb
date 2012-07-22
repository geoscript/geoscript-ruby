java_import com.vividsolutions.jts.geom.Coordinate
JTSLinearRing = com.vividsolutions.jts.geom.LinearRing

module GeoScript
  module Geom
    class LinearRing < JTSLinearRing
      include GeoScript::Geom

      def initialize(*args);end

      def self.create(*coords)
        if coords.size == 1
          LinearRing.new coords.first.coordinate_sequence if coords.first.kind_of? LinearRing
        else
          line_string = LineString.create *coords
          LinearRing.new line_string.coordinate_sequence, GEOM_FACTORY
        end
      end

      def to_wkt
        IO.write_wkt self
      end

      def to_json
        IO.write_json self
      end
    end
  end
end