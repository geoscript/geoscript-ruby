java_import org.geotools.feature.simple.SimpleFeatureBuilder
ogFeature = org.opengis.feature.Feature

module GeoScript
  module Feature
    class Feature
      def initialize(attrs = nil, id = nil, schema = nil, feature = nil)
        if attrs
          unless schema
            if attrs.instance_of? Hash
              schema_attrs = []
              attrs.each do |k, v|
                schema_attrs << {name: k, type: v.to_java.java_class}
              end
              @schema = Schema.new('feature', schema_attrs)
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
        elsif feature
          @feature = feature
          @schema = schema ? schema : GeoScript::Feature::Schema.new(feature.feature_type)
        else
          raise 'No attributes specified for feature'
        end
      end

      def get_id
        @feature.identifier.to_s
      end

      def get_geom
        @feature.default_geometry
      end

      def set_geom(geom)
        @feature.default_geometry = geom
      end
    end
  end
end