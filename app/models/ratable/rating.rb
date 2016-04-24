module Ratable
  class Rating < ActiveRecord::Base
    belongs_to :ratee, polymorphic: true
    belongs_to :rater, polymorphic: true

    validates_presence_of :ratee, :value

    scope :by_ratee, -> (ratee) { where(ratee: ratee) }
    scope :by_rater, -> (rater) { where(rater: rater) }

    def average
    end
  end
end
