module Ratable
  module Models
    module Rater
      extend ActiveSupport::Concern

      attr_reader :has_one

      module ActiveRecordExtension
        def acts_as_rater(options={has_one: false})
          raise "To make a model the rater and the ratee use `acts_as_ratable`" if acts_like_ratee?
          @has_one = options[:has_one]
          include Rater
        end

        def acts_like_rater?
          ancestors.include?(Rater)
        end
      end

      module ActiveRecordInclusion
        def acts_like_rater?
          self.class.ancestors.include?(Rater)
        end
      end

      included do
        if @has_one
          has_one :rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
        else
          has_many :ratings, -> { order(updated_at: :desc) }, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
        end
      end

      def rating_average
        if @has_one
          ::Ratable::RatingAverage.new(ratings: rating, rater: self)
        else
          ::Ratable::RatingAverage.new(ratings: ratings, rater: self)
        end
      end

      def ratees
        if @has_one
          rating.ratee
        else
          ratings.includes(:ratee).collect { |rating| rating.ratee }
        end
      end

      def rate(options={})
        options.reject! { |k| k == :rater }
        if @has_one
          rating.create(options)
        else
          ratings.create(options)
        end
      end

    end
  end
end
