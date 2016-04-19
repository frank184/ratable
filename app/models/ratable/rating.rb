module Ratable
  class Rating < ActiveRecord::Base
    belongs_to :ratee, polymorphic: true
    belongs_to :rater, polymorphic: true

    scope :by_ratee, -> (ratee) { where(ratee: ratee) }
    scope :by_rater, -> (rater) { where(rater: rater) }
  end
end
