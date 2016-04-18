module Ratable
  module Models
    module Ratable
      extend ActiveSupport::Concern

      def acts_as_ratable
        include Ratable::Models::Ratable
      end

      included do
        has_many :ratings, class_name: 'Ratable::Raiting', as: :ratings
      end

      def rating_average
        sum = 0
        ratings.each { |rating| sum += rating.value }
        return sum / ratings.count
      end

      def rate(value, comment)
        rating = Rating.new({
          model_id: self.id,
          model_type: self.class.to_s,
          value: value,
          comment: comment
        }).build
      end

    end
  end
end