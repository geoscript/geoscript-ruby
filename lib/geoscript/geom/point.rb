module GeoScript
  module Geom
    java_import com.vividsolutions.jts.geom.Coordinate
    JTSPoint = com.vividsolutions.jts.geom.Point

    class Point < JTSPoint
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*coords)
        if coords.first.kind_of? JTSPoint
          p = coords.first
        else
          if coords.empty?
            c = Coordinate.new 0, 0
          else
            c = Coordinate.new coords[0], coords[1]
            c.z = coords[2] if coords[2]
          end
          
          p = GEOM_FACTORY.create_point c
        end
        super p.coordinate_sequence, GEOM_FACTORY
      end

      def buffer(dist)
        Polygon.new super
      end

      def to_wkt
        GeoScript::IO::Geom.write_wkt self
      end

      def to_wkb
        GeoScript::IO::Geom.write_wkb self
      end

      def to_json
        GeoScript::IO::Geom.write_json self
      end
    end
  end
end
