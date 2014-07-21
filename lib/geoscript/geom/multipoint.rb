module GeoScript
  module Geom
    JTSMultiPoint = com.vividsolutions.jts.geom.MultiPoint
    
    class MultiPoint < JTSMultiPoint
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*points)
        feature_points =
          if points.first.kind_of? JTSMultiPoint
            points.first.points
          else
            [].tap do |fp|
              points.each do |point|
                fp << (point.kind_of?(Point) ? point : Point.new(*point))
              end
            end
          end

        super(feature_points.to_java(com.vividsolutions.jts.geom.Point), GEOM_FACTORY)
      end

      def points
        [].tap do |geometries|
          for i in 0...self.num_geometries do
            geometries << self.geometry_n(i)
          end
        end
      end

      def <<(*new_points)
        MultiPoint.new *(points << new_points)
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
