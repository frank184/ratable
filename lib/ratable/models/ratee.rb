module Ratable
  module Models
    module Ratee
      extend ActiveSupport::Concern

      attr_reader :has_one

      module ActiveRecordExtension
        def acts_as_ratee(options={has_one: false})
          raise "To make a model the rater and the ratee use `acts_as_ratee_and_rater`" if acts_like_rater?
          @has_one = options[:has_one]
          include Ratee
        end

        def acts_like_ratee?
          ancestors.include?(Ratee)
        end
      end

      module ActiveRecordInclusion
        def acts_like_ratee?
          self.class.ancestors.include?(Ratee)
        end
      end

      included do
        if @has_one
          has_one :rating, class_name: ::Ratable::Rating, dependent: :destroy, as: :ratee
        else
          has_many :ratings, -> { order(updated_at: :desc) }, class_name: ::Ratable::Rating, dependent: :destroy, as: :ratee
        end
      end

      def rating_average
        if rating.present?
          ::Ratable::RatingAverage.new(ratings: rating, ratee: self)
        else
          ::Ratable::RatingAverage.new(ratings: ratings, ratee: self)
        end
      end

      def raters
        if rating.present?
          rating.rater
        else
          ratings.includes(:rater).collect { |rating| rating.rater }
        end
      end

      def rate(options={})
        options.reject! { |k| k == :ratee }
        if rating.present?
          create_rating(options)
        else
          ratings.create(options)
        end
      end

    end
  end
end
