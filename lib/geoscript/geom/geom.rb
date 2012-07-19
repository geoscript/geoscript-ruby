java_import java.awt.geom.AffineTransform
java_import com.vividsolutions.jts.geom.GeometryFactory
java_import com.vividsolutions.jts.geom.Geometry
java_import com.vividsolutions.jts.geom.prep.PreparedGeometryFactory
java_import com.vividsolutions.jts.simplify.DouglasPeuckerSimplifier
java_import com.vividsolutions.jts.triangulate.DelaunayTriangulationBuilder
java_import com.vividsolutions.jts.triangulate.VoronoiDiagramBuilder
java_import com.vividsolutions.jts.operation.buffer.BufferParameters
java_import com.vividsolutions.jts.operation.buffer.BufferOp
java_import org.geotools.geometry.jts.JTS
java_import org.geotools.referencing.operation.transform.AffineTransform2D

module GeoScript
  module Geom
    GEOM_FACTORY = GeometryFactory.new
    PREP_FACTORY = PreparedGeometryFactory.new

    def self.prepare(geom)
      PREP_FACTORY.create(geom)
    end

    def self.simplify(geom, tolerance)
      DouglasPeuckerSimplifier.simplify(geom, tolerance)
    end

    def self.buffer(geom, distance, single_sided = false)
      buffer_params = BufferParameters.new
      buffer_params.set_single_sided(single_sided)
      BufferOp.buffer_op(geom, distance, buffer_params)
    end

    def self.get_bounds(geom)
      Bounds.create geom.get_envelope_internal
    end

    def self.enhance(geom)
      geom.bounds = Geom.get_bounds geom
    end
  end
end