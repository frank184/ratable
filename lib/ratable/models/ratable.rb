module Ratable
  module Models
    module Ratable
      extend ActiveSupport::Concern

      module ActiveRecordExtension
        def acts_as_ratable(options={has_one_ratee: false, has_one_rater: false, self_rate: false})
          @has_one_ratee = options[:has_one_ratee]
          @has_one_rater = options[:has_one_rater]
          @self_rate = options[:self_rate]
          include Ratable
        end

        def acts_like_ratable?
          ancestors.include?(Ratable)
        end
      end

      module ActiveRecordInclusion
        def acts_like_ratable?
          ancestors.include?(Ratable)
        end
      end

      included do
        if @has_one_ratee
          has_one :ratee_rating, class_name: Ratable::Rating, dependent: :destroy, as: :ratee
        else
          has_many :ratee_ratings, -> { order(updated_at: :desc) }, class_name: Ratable::Rating, dependent: :destroy, as: :ratee
        end
        if @has_one_rater
          has_one :rater_rating, class_name: Ratable::Rating, dependent: :destroy, as: :rater
        else
          has_many :rater_ratings, -> { order(updated_at: :desc) }, class_name: Ratable::Rating, dependent: :destroy, as: :rater
        end
      end

      def ratee_rating_average
        if ratee_rating.present?
          ::Ratable::RatingAverage.new(ratings: ratee_rating, ratee: self)
        else
          ::Ratable::RatingAverage.new(ratings: ratee_rating, ratee: self)
        end
      end

      def rater_rating_average
        if rateR_rating.present?
          ::Ratable::RatingAverage.new(ratings: rater_rating, rater: self)
        else
          ::Ratable::RatingAverage.new(ratings: rater_ratings, rater: self)
        end
      end

      def ratees
        if rater_rating.present?
          rater_rating.ratee
        else
          rater_rating.includes(:ratee).collect { |rating| rating.ratee }
        end
      end

      def raters
        if ratee_rating.present?
          ratee_rating.rater
        else
          ratee_ratings.includes(:rater).collect { |rating| rating.rater }
        end
      end

      def ratee_rate(options={})
        options.reject! { |k| k == :ratee }
        if ratee_rating.present?
          ratee_rating.create(options)
        else
          ratee_rating.create(options)
        end
      end

      def rater_rate(options)
        options.reject! { |k| k == :rater }
        if rater_rating.present?
          rater_rating.create(options)
        else
          rater_ratings.create(options)
        end
      end

      def rate(options)
        if options[:ratee]
          rater_rate(options)
        else
          ratee_rate(options)
        end
      end
    end
  end
end
