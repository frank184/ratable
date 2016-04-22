require 'rails'

module Ratable
  class Engine < ::Rails::Engine
    isolate_namespace Ratable
    initializer "ratable.models.ratee" do
      ActiveSupport.on_load(:active_record) do
        extend Ratable::Models::Ratable::ActiveRecordExtension
        include Ratable::Models::Ratable::ActiveRecordInclusion
      end
    end
    initializer "ratable.models.ratee" do
      ActiveSupport.on_load(:active_record) do
        extend Ratable::Models::Ratee::ActiveRecordExtension
      end
    end
    initializer "ratable.models.rater" do
      ActiveSupport.on_load(:active_record) do
        extend Ratable::Models::Rater::ActiveRecordExtension
      end
    end
  end
end
