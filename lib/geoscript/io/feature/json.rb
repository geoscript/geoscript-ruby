java_import org.geotools.geojson.feature.FeatureJSON

module GeoScript
  module IO
    module Feature
      def self.write_json(feature)
        FeatureJSON.new.to_string feature
      end

      def self.read_json(json)
        GeoScript::Feature.new(FeatureJSON.new.read_feature(json))
      end
    end
  end
end