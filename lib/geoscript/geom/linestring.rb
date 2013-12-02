module GeoScript
  module Geom
    java_import com.vividsolutions.jts.geom.Coordinate
    JTSLineString = com.vividsolutions.jts.geom.LineString

    class LineString < JTSLineString
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*coords)
        if coords.size == 1
          if coords.first.kind_of? JTSLineString
            ls = coords.first
          elsif coords.kind_of? Array
            if coords.first.kind_of? Array
              l = []
              coords.first.each do |coord|
                l << Coordinate.new(coord[0], coord[1])
                l.last.z = coord[2] if coord[2]
              end
              if l.size > 0
                ls = GEOM_FACTORY.create_line_string l.to_java(com.vividsolutions.jts.geom.Coordinate)
              end
            end
          end
        else
          l = []
          coords.each do |coord|
            l << Coordinate.new(coord[0], coord[1])
            l.last.z = coord[2] if coord[2]
          end
          if l.size > 0
            ls = GEOM_FACTORY.create_line_string l.to_java(com.vividsolutions.jts.geom.Coordinate)
          end
        end

        if ls
          super(ls.coordinate_sequence, GEOM_FACTORY)
        else
          raise 'LineString could not be created. Check inputs.'
        end
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
