java_import org.geotools.feature.simple.SimpleFeatureBuilder

module GeoScript
  class Feature
    def initialize(attrs = nil, id = nil, schema = nil, feature = nil)
      if attrs
        if attrs.kind_of? Array
          raise 'Cannot be array ...' unless schema
        end
      end

      @attrs = attrs
      @id = id
      @schema = schema
      @feature = feature
    end

    
  end
end