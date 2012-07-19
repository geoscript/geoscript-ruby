java_import com.vividsolutions.jts.geom.Coordinate
JTSPoint = com.vividsolutions.jts.geom.Point

module GeoScript
  module Geom
    class Point < JTSPoint
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*args);end

      def self.create(x, y = nil, z = nil)
        c = Coordinate.new x, y
        p = GEOM_FACTORY.create_point c
        Point.new p.coordinate_sequence, GEOM_FACTORY
      end

      def to_wkt
        "POINT(#{self.x} #{self.y})"
      end
    end
  end
end