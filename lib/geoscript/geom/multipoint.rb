JTSMultiPoint = com.vividsolutions.jts.geom.MultiPoint

module GeoScript
  module Geom
    class MultiPoint < JTSMultiPoint
      include GeoScript::Geom

      attr_accessor :bounds

      def intitialize(*args);end

      def self.create(*points)
        feature_points = []

        if points.first.kind_of? MultiPoint
          multi_point = points.first

          for i in (0...multi_point.num_geometries)
            feature_points << multi_point.get_geometry_n(i)
          end
        else
          points.each do |point|
            if point.kind_of? Point
              feature_points << point
            else
              feature_points << Point.create(*point)
            end
          end
        end

        MultiPoint.new feature_points.to_java(com.vividsolutions.jts.geom.Point), GEOM_FACTORY
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