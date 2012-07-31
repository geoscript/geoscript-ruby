java_import com.vividsolutions.jts.geom.Coordinate
JTSPoint = com.vividsolutions.jts.geom.Point

module GeoScript
  module Geom
    class Point < JTSPoint
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*args);end

      def self.create(x, y = nil, z = nil)
        if x.kind_of? JTSPoint
          p = x
        else
          c = Coordinate.new x, y
          p = GEOM_FACTORY.create_point c
        end

        point = Point.new p.coordinate_sequence, GEOM_FACTORY
        GeoScript::Geom.enhance point
        point
      end

      def buffer(dist)
        Polygon.create super
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