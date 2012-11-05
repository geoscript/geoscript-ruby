java_import org.geotools.data.memory.MemoryDataStore

module GeoScript
  module DataStore
    class Memory < MemoryDataStore
      def initialize(params)
        super()
      end
    end
  end
end