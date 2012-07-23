java_import com.vividsolutions.jts.geom.Coordinate
JTSLinearRing = com.vividsolutions.jts.geom.LinearRing

module GeoScript
  module Geom
    class LinearRing < JTSLinearRing
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*args);end

      def self.create(*coords)
        if coords.size == 1
          linear_ring = LinearRing.new coords.first.coordinate_sequence if coords.first.kind_of? LinearRing
        else
          line_string = LineString.create *coords
          linear_ring = LinearRing.new line_string.coordinate_sequence, GEOM_FACTORY
        end
        GeoScript::Geom.enhance linear_ring
        linear_ring
      end

      def to_wkt
        IO.write_wkt self
      end

      def to_wkb
        IO.write_wkb self
      end

      def to_json
        IO.write_json self
      end
    end
  end
end