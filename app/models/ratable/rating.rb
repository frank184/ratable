module Ratable
  class Rating < ActiveRecord::Base
    belongs_to :ratee, polymorphic: true
    belongs_to :rater, polymorphic: true
  end
end
