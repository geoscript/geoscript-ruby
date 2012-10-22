JInt = java.lang.Integer

module GeoScript
  module Util
    class Bytes
      def self.decode(str, base)
        str.to_java_bytes
      end

      def self.encode(bytes, base)
        bytes.from_java_bytes
      end

      def self.byte_to_string(byte, base)
        n = Math.log(256, base).ceil
        s = byte < 0 ? java.lang.Integer.to_string(((b.abs ^ 0xff) + 0x01), base) : java.lang.Integer.to_string(b, base)
        "%0#{n}d" % s
      end

      def self.string_to_byte(string, base)
        int = string.to_i(base)
        if int > 128
          -1 * ((int ^ 0xff) + 0x01)
        else
          int
        end
      end
    end
  end
end