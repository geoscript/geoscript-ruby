java_import com.vividsolutions.jts.io.WKBReader
java_import com.vividsolutions.jts.io.WKBWriter

module GeoScript
  module IO
    module Geom
      include GeoScript::Util

      def self.write_wkb(geom)
        wkb = WKBWriter.new.write geom
        WKBWriter.bytes_to_hex wkb
      end

      def self.read_wkb(wkb)
        if wkb.kind_of? String
          wkb = WKBReader.hex_to_bytes wkb
        elsif wkb.kind_of? Array
          # .to_java(java.lang.Byte) does not seem to work
          # this is very hacky
          wkb = WKBWriter.bytes_to_hex wkb
          wkb = WKBReader.hex_to_bytes wkb
        end
        WKBReader.new.read wkb
      end
    end
  end
end