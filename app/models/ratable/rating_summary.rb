module Ratable
  class RatingSummary
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :ratee, :rater, :ratings

    def initialize(attributes={})
      super
    end

    validates_presence_of :ratings
    validates_presence_of :ratee, unless: :rater.present?
    validates_presence_of :rater, unless: :ratee.present?
    validate :ratee_or_rater_not_both

    def ratee_or_rater_not_both
      errors.add(:both_ratee_and_rater_are_defined, "either this is a ratee's ratings summary or a rater's ratings summary, not both")
    end

    def average
    end
  end
end
