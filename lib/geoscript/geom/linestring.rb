java_import com.vividsolutions.jts.geom.Coordinate
JTSLineString = com.vividsolutions.jts.geom.LineString

module GeoScript
  module Geom
    class LineString < JTSLineString
      include GeoScript::Geom

      def initialize(*args);end

      def self.create(*coords)
        if coords.size == 1
          ls = coords.first if coords.first.kind_of? LineString
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
          line_string = LineString.new ls.coordinate_sequence, GEOM_FACTORY
          GeoScript::Geom.enhance line_string
          line_string
        else
          raise 'LineString could not be created. Check inputs.'
        end
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