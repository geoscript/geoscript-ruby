module GeoScript
  module Geom
    JTSMultiPolygon = com.vividsolutions.jts.geom.MultiPolygon
    JTSPolygon = com.vividsolutions.jts.geom.Polygon unless defined?(JTSPolygon)
    
    class MultiPolygon < JTSMultiPolygon
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*polygons)
        polys =
          if polygons.first.kind_of? JTSMultiPolygon
            mp = polygons.first

            [].tap do |p|
              for i in 0...mp.num_geometries
                p << mp.geometry_n(i)
              end
            end
          else
            [].tap do |p|
              polygons.each do |polygon|
                p << (polygon.kind_of?(JTSPolygon) ? polygon : Polygon.new(*polygon))
              end
            end
          end

        super(polys.to_java(com.vividsolutions.jts.geom.Polygon), GEOM_FACTORY)
      end

      def polygons
        [].tap do |g|
          for i in 0...num_geometries do
            g << geometry_n(i)
          end
        end
      end

      def <<(*new_polygons)
        MultiPolygon.new *(polygons << new_polygons)
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
