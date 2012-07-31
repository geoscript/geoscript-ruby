JTSMultiPolygon = com.vividsolutions.jts.geom.MultiPolygon

module GeoScript
  module Geom
    class MultiPolygon < JTSMultiPolygon
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*args);end

      def self.create(*polygons)
        polys = []

        if polygons.first.kind_of? MultiPolygon
          multi_polygon = polygons.first
          for i in range(0...multi_polygon.num_geometries)
            polys << multi_polygon.get_geometry_n(i)
          end
        else
          polygons.each do |polygon|
            if polygon.kind_of? Polygon
              polys << polygon
            else
              polys << Polygon.create(*polygon)
            end
          end
        end

        multi_poly = MultiPolygon.new polys.to_java(com.vividsolutions.jts.geom.Polygon), GEOM_FACTORY
        GeoScript::Geom.enhance multi_poly
        multi_poly
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