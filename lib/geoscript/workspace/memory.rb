java_import org.geotools.data.memory.MemoryDataStore

module GeoScript
  module Workspace
    class Memory < MemoryDataStore
      def initialize; super; end
    end
  end
end