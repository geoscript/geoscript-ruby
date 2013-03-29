module GeoScript
  class Field
    attr_accessor :name, :type, :proj

    def initialize(name, type, proj=nil)
      @name = name
      @type = type
      @proj = proj
    end

    def to_s
      "#{@name}: #{@type}"
    end

    def ==(other)
      other.name == @name && other.type == @type && other.proj == @proj
    end
  end
end
