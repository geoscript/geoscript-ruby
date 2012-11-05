java_import org.geotools.feature.simple.SimpleFeatureBuilder
ogFeature = org.opengis.feature.Feature

module GeoScript
  class Feature
    def initialize(attrs = nil, id = nil, schema = nil)
      raise 'No attributes specified for feature' unless attrs
      
      unless attrs.kind_of? GeoScript::Feature
        unless schema
          if attrs.instance_of? Hash
            schema_attrs = []
            attrs.each do |k, v|
              schema_attrs << {name: k, type: v.to_java.java_class}
            end
            @schema = GeoScript::Schema.new('feature', schema_attrs)
          elsif attrs.instance_of? Array
            raise 'Attributes may only be given as Array if schema is specified'
          end
        else
          @schema = schema
        end

        if attrs.instance_of? Array
          attrs_hash = {}
          attrs.each_with_index {|v, i| attrs_hash[@schema.fields[i].name] = v}
          attrs = attrs_hash
        end

        sfb = SimpleFeatureBuilder.new @schema.feature_type
        attrs.each {|k, v| sfb.set(k, v)}
        @feature = sfb.build_feature id
      else
        @feature = attrs
        @schema = schema ? schema : GeoScript::Schema.new(@feature.feature_type)
      end
    end

    def id
      @feature.identifier.to_s
    end

    def geom
      @feature.default_geometry
    end

    def set_geom(geom)
      @feature.default_geometry = geom
    end
  end
end