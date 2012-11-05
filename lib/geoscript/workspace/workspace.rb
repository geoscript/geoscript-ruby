java_import org.geotools.data.DataStore

module GeoScript
    class Workspace
      DS_TYPES = {
        'memory' => GeoScript::Workspace::Memory
      }

      def initialize(store, params)
        unless store
          @store = GeoScript::Workspace::Memory.new
        elsif store.kind_of? DataStore
          @store = store
        elsif DS_TYPES[store]
          @store = DS_TYPES[store].new(params)
        end
      end
    end
  end
end