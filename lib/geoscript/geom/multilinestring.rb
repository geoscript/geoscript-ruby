module GeoScript
  module Geom
    JTSMultiLineString = com.vividsolutions.jts.geom.MultiLineString

    class MultiLineString < JTSMultiLineString
      include GeoScript::Geom

      attr_accessor :bounds

      def initialize(*line_strings)
        strings = []

        if line_strings.first.kind_of? JTSMultiLineString
          multi_line_string_geom = line_strings.first

          for i in (0...multi_line_string_geom.num_geometries)
            strings << multi_line_string_geom.get_geometry_n(i)
          end
        else
          line_strings.each do |line_string|
            if line_string.kind_of? LineString
              strings << line_string
            else
              strings << LineString.new(*line_string)
            end
          end
        end

        super(strings.to_java(com.vividsolutions.jts.geom.LineString), GEOM_FACTORY)
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
