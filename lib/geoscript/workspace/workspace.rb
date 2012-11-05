java_import org.geotools.data.DataStore

module GeoScript
  module Workspace
    class Workspace < DataStore
      def initialize(store = nil, params = nil)
        unless store
          @store = GeoScript::Workspace::Memory.new
        elsif store.respond_to? :create
        end
      end
    end
  end
end