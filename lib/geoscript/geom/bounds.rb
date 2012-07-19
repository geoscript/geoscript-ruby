java_import com.vividsolutions.jts.geom.Envelope
java_import org.geotools.geometry.jts.ReferencedEnvelope

module GeoScript
  module Geom
    class Bounds < ReferencedEnvelope
      include GeoScript::Geom

      def initialize(*args);end

      def self.create(env, proj = nil)
        projection = GeoScript::Projection.new proj if proj

        if env.kind_of? Envelope
          if projection
            bounds = Bounds.new env, projection
          elsif env.respond_to? :crs
            if env.crs
              bounds = Bounds.new env, env.crs
            else
              bounds = Bounds.new env, nil
            end
          end
        else
          if env.kind_of? Hash
            if projection
              bounds = Bounds.new env[:x_min], env[:x_max], env[:y_min], env[:y_max], projection
            else
              bounds = Bounds.new env[:x_min], env[:x_max], env[:y_min], env[:y_max], nil
            end
          elsif env.kind_of? Array
            if projection
              bounds = Bounds.new env[0], env[1], env[2], env[3], projection
            else
              bounds = Bounds.new env[0], env[1], env[2], env[3]
            end
          else
            bounds = Bounds.new
          end
        end
        
        bounds
      end

      def get_west
        self.min_x
      end

      def get_south
        self.min_y
      end

      def get_east
        self.max_x
      end

      def get_north
        self.max_y
      end

      def get_projection
        crs = self.coordinate_reference_system
        GeoScript::Projection.new crs if crs
      end

      def self.scale(bounds, factor)
        width = self.width * (factor - 1) / 2
        height = self.height * (factor - 1) / 2

        Bounds.new self.west - width, self.south - height, self.east + width, self.north + height
      end

      def expand(other_bounds);end

      def to_polygon;end

      def tile(resolution);end
    end
  end
end