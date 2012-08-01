java_import com.vividsolutions.jts.geom.Coordinate
JTSPoint = com.vividsolutions.jts.geom.Point

module GeoScript
  module Geom
    class Point < JTSPoint
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*coords)
        if coords.first.kind_of? JTSPoint
          p = coords.first
        else
          c = Coordinate.new coords[0], coords[1]
          c.z = coords[2] if coords[2]
          p = GEOM_FACTORY.create_point c
        end
        super p.coordinate_sequence, GEOM_FACTORY
      end

      def buffer(dist)
        Polygon.new super
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