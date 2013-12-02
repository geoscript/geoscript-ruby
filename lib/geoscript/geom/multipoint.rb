module GeoScript
  module Geom
    JTSMultiPoint = com.vividsolutions.jts.geom.MultiPoint
    
    class MultiPoint < JTSMultiPoint
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*points)
        feature_points = []

        if points.first.kind_of? JTSMultiPoint
          mp_geom = points.first

          for i in (0...mp_geom.num_geometries)
            feature_points << mp_geom.get_geometry_n(i)
          end
        else
          points.each do |point|
            if point.kind_of? Point
              feature_points << point
            else
              feature_points << Point.new(*point)
            end
          end
        end

        super(feature_points.to_java(com.vividsolutions.jts.geom.Point), GEOM_FACTORY)
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
