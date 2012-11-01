java_import org.opengis.feature.type.FeatureType
java_import org.opengis.feature.type.GeometryDescriptor
java_import org.geotools.feature.NameImpl
java_import org.geotools.feature.simple.SimpleFeatureTypeBuilder

module GeoScript
  module Feature
    class Schema
      include GeoScript::Feature

      attr_accessor :feature_type

      def initialize(name = nil, fields = [], type = nil, uri = 'http://geoscript.org/feature')
        if name && !fields.empty?
          type_builder = SimpleFeatureTypeBuilder.new
          type_builder.set_name NameImpl.new(name)
          type_builder.setNamespaceURI uri
          fields.each do |field|
            if field.instance_of? GeoScript::Feature::Field
              name, type, proj = field.name, field.type, field.proj
            else
              if field.instance_of? Hash
                name, type = field.keys.first, field.values.first
              elsif field.instance_of? Array
                name, type = field[0], field[1]

                if type.kind_of? GeoScript::Geom
                  proj = GeoScript::Projection.new(field[2]) if field[2]
                else
                  raise 'Invalid type specified. Must be of type GeoScript::Geom::*'
                end
              end
            end
            type_builder.crs proj if proj
            type_builder.add name, type.java_class
            @feature_type = type_builder.build_feature_type
          end
        else
          raise "No fields specified for feature type: #{type}"
        end
      end

      def get_name
        @feature_type.name.local_part
      end

      def get_uri
        @feature_type.name.namespaceURI
      end

      def get_proj
        crs = @feature_type.coordinate_reference_system
        GeoScript::Projection.new crs if crs
      end

      def get(name)
        ad = @feature_type.get_descriptor name
      end
    end
  end
end