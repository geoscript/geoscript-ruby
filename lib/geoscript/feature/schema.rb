java_import org.opengis.feature.type.FeatureType
java_import org.opengis.feature.type.GeometryDescriptor
java_import org.geotools.feature.NameImpl
java_import org.geotools.feature.simple.SimpleFeatureTypeBuilder

module GeoScript
  class Schema
    attr_accessor :feature_type

    def initialize(name=nil, fields=[], type=nil, uri='http://geoscript.org/feature')
      if name && !fields.empty?
        type_builder = SimpleFeatureTypeBuilder.new
        type_builder.set_name NameImpl.new(name)
        type_builder.setNamespaceURI uri
        fields.each do |field|
          if field.instance_of? GeoScript::Field
            name, type, proj = field.name, field.type, field.proj
          elsif field.instance_of? Hash
            if field[:name] && field[:type]
              name, type = field[:name], field[:type]
            else
              name, type = field.keys.first, field.values.first
            end

            if type.name.match /GeoScript::Geom/
              proj = GeoScript::Projection.new(field[:proj]) if field[:proj]
            end
          elsif field.instance_of? Array
            name, type = field[0], field[1]

            if type.name.match /GeoScript::Geom/
              proj = GeoScript::Projection.new(field[2]) if field[2]
            end
          end
          type_builder.crs proj if proj

          if type.name.match /GeoScript::Geom/
            type = type.superclass.java_class
          else
            type = type.to_java.java_class
          end

          type_builder.add name, type
        end
        @feature_type = type_builder.build_feature_type
      else
        if !name && fields.empty?
          raise "No name specified & No fields specified for type: #{type}"
        elsif fields.empty?
          raise "No fields specified for type: #{type}" if fields.empty?
        elsif !name
          raise 'No name specified'
        end
      end
    end

    def get_name
      @feature_type.name.local_part
    end
    alias_method :name, :get_name

    def get_geom
      @feature_type.geometry_descriptor.local_name
    end
    alias_method :geom, :get_geom

    def uri
      @feature_type.name.namespaceURI
    end

    def get_proj
      crs = @feature_type.coordinate_reference_system
      GeoScript::Projection.new crs if crs
    end
    alias_method :proj, :get_proj

    def get_fields
      fields = []

      @feature_type.attribute_descriptors.each do |ad|
        fields << self.get(ad.local_name)
      end

      fields
    end
    alias_method :fields, :get_fields

    def get(name)
      ad = @feature_type.get_descriptor name
      GeoScript::Field.new(ad.local_name, ad.type.binding, ad.coordinate_reference_system)
    rescue NoMethodError
      return nil
    end
  end
end
