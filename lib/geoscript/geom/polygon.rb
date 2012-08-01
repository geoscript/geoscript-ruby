JTSPolygon = com.vividsolutions.jts.geom.Polygon

module GeoScript
  module Geom
    class Polygon < JTSPolygon
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*rings)
        if rings.first.kind_of? JTSPolygon
          interior_rings = []
          num_rings = rings.first.num_interior_ring
          for i in (0...num_rings)
            interior_rings << rings.first.get_interior_ring_n(i)
          end
          shell = rings.first.exterior_ring
          holes = interior_rings.to_java(com.vividsolutions.jts.geom.LinearRing)
        else
          linear_rings = []
          rings.each do |ring|
            if ring.kind_of? LinearRing
              linear_rings << ring
            else
              linear_rings << LinearRing.new(*ring)
            end
          end
          
          shell = linear_rings.first
          holes = linear_rings[1..linear_rings.size].to_java(com.vividsolutions.jts.geom.LinearRing)
        end
        super(shell, holes, GEOM_FACTORY)
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