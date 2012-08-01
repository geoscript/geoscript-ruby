JTSMultiPolygon = com.vividsolutions.jts.geom.MultiPolygon

module GeoScript
  module Geom
    class MultiPolygon < JTSMultiPolygon
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*polygons)
        polys = []

        if polygons.first.kind_of? JTSMultiPolygon
          multi_polygon = polygons.first
          for i in range(0...multi_polygon.num_geometries)
            polys << multi_polygon.get_geometry_n(i)
          end
        else
          polygons.each do |polygon|
            if polygon.kind_of? Java::ComVividsolutionsJtsGeom::Polygon
              polys << polygon
            else
              polys << Polygon.new(*polygon)
            end
          end
        end
        super(polys.to_java(com.vividsolutions.jts.geom.Polygon), GEOM_FACTORY)
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