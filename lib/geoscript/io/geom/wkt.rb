java_import com.vividsolutions.jts.io.WKTReader
java_import com.vividsolutions.jts.io.WKTWriter

module GeoScript
  module IO
    module Geom
      def self.read_wkt(wkt)
        WKTReader.new.read wkt
      end

      def self.write_wkt(geom)
        WKTWriter.new.write geom
      end
    end
  end
end