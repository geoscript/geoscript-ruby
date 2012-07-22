JInt = java.lang.Integer

module GeoScript
  module Util
    class Bytes
      def self.decode(str, base) # str.to_java_bytes
        #n = Math.log(256, base).ceil
        #bytes = []
        #(0...str.size).step(n) do |i|
        #  bytes << string_to_byte(str[i...(i + n)].join(''), base)
        #end
        #bytes.to_java java.lang.Byte
        str.to_java_bytes
      end

      def self.encode(bytes, base) # bytes.from_java_bytes
        #bytes_array = []
        #
        #bytes.each do |byte|
        #  bytes_array << byte_to_string(byte, base)
        #end
        #
        #bytes_array.join ''
        bytes.from_java_bytes
      end

      def self.byte_to_string(byte, base)
        n = Math.log(256, base).ceil
        s = byte < 0 ? JInt.to_string(((b.abs ^ 0xff) + 0x01), base) : JInt.to_string(b, base)
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