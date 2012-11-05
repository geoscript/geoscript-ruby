java_import org.geotools.data.DataStore

module GeoScript
  class Workspace
    DS_TYPES = {
      'memory' => GeoScript::DataStore::Memory
    }

    attr_accessor :store

    def initialize(store = nil, params = nil)
      unless store
        @store = GeoScript::DataStore::Memory.new(params)
      else
        if DS_TYPES[store]
          @store = DS_TYPES[store].new(params)
        end
      end
    end
  end
end