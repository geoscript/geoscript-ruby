module GeoScript
  module Geom
    java_import com.vividsolutions.jts.geom.Envelope
    java_import org.geotools.geometry.jts.ReferencedEnvelope

    class Bounds < ReferencedEnvelope
      include GeoScript::Geom

      def initialize(env, proj = nil)
        projection = GeoScript::Projection.new proj if proj

        if env.kind_of? Envelope
          if projection
            super(env, projection)
          elsif env.respond_to? :crs
            if env.crs
              super(env, env.crs)
            else
              super(env, nil)
            end
          else
            super(env, nil)
          end
        else
          if env.kind_of? Hash
            if projection
              super(env[:x_min], env[:x_max], env[:y_min], env[:y_max], projection)
            else
              super(env[:x_min], env[:x_max], env[:y_min], env[:y_max], nil)
            end
          elsif env.kind_of? Array
            if projection
              super(env[0], env[1], env[2], env[3], projection)
            else
              super(env[0], env[1], env[2], env[3])
            end
          else
            super()
          end
        end
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

      def get_aspect
        self.width / self.height
      end

      def scale(factor)
        width = self.width * (factor - 1) / 2
        height = self.height * (factor - 1) / 2

        Bounds.new self.west - width, self.south - height, self.east + width, self.north + height
      end

      def expand(other)
        self.expand_to_include(other)
      end

      def to_polygon;end

      def tile(resolution);end
    end
  end
end
