require 'rails'

module Ratable
  class Engine < ::Rails::Engine
    isolate_namespace Ratable
    initializer "ratable.models.ratable" do
      ActiveSupport.on_load(:active_record) do
        extend Ratable::Models::Ratable::ActiveRecordExtension
        include Ratable::Models::Ratable::ActiveRecordInclusion
      end
    end
    initializer "ratable.models.ratee" do
      ActiveSupport.on_load(:active_record) do
        extend Ratable::Models::Ratee::ActiveRecordExtension
        include Ratable::Models::Ratee::ActiveRecordInclusion
      end
    end
    initializer "ratable.models.rater" do
      ActiveSupport.on_load(:active_record) do
        extend Ratable::Models::Rater::ActiveRecordExtension
        include Ratable::Models::Rater::ActiveRecordInclusion
      end
    end
    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
