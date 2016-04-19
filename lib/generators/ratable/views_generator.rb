class Ratable::ViewsGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../../app/views/ratable", __FILE__)

  def copy_views
    directory('ratings', 'app/views/ratable/ratings')
  end
end
