JTSMultiLineString = com.vividsolutions.jts.geom.MultiLineString

module GeoScript
  module Geom
    class MultiLineString < JTSMultiLineString
      include GeoScript::Geom

      def initialize(*args);end

      def self.create(*line_strings)
        strings = []

        if line_strings.first.kind_of? MultiLineString
          multi_line_string = line_strings.first
          for i in range(0...multi_line_string.num_geometries)
            strings << multi_line_string.get_geometry_n(i)
          end
        else
          line_strings.each do |line_string|
            if line_string.kind_of? LineString
              strings << line_string
            else
              strings << LineString.create(*line_string)
            end
          end
        end

        MultiLineString.new strings.to_java(com.vividsolutions.jts.geom.LineString), GEOM_FACTORY
      end

      def to_wkt
        IO.write_wkt self
      end

      def to_json
        IO.write_json self
      end
    end
  end
end