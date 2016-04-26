module Ratable
  class RatingAverage
    include ActiveModel::Model

    attr_accessor :ratings, :value, :rater, :ratee

    def initialize(attributes={})
      attributes.reject! { |k| k == :value }
      attributes.each { |k,v| send("#{k}=", v) }
      @value = @ratings.average(:value).to_i
    end

  end
end
