module Ratable
  class Engine < ::Rails::Engine
    isolate_namespace Ratable
    initializer "ratable.models.ratable" do
      ActiveSupport.on_load(:active_record) do
        extend Ratable::Models::Ratable::ActiveRecordExtension
      end
    end
  end
end
