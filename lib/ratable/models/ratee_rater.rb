module Ratable
  module Models
    module RateeRater
      extend ActiveSupport::Concern

      attr_reader :has_one_ratee, :has_one_rater

      module ActiveRecordExtension
        def acts_as_ratee_and_rater(options={has_one_ratee: false, has_one_rater: false})
          @has_one_ratee = options[:has_one_ratee]
          @has_one_rater = options[:has_one_rater]
          include RateeRater
        end

        def acts_as_rater_and_ratee(options={has_one_ratee: false, has_one_rater: false})
          @has_one_ratee = options[:has_one_ratee]
          @has_one_rater = options[:has_one_rater]
          include RateeRater
        end
      end

      included do
        if @has_one_ratee
          has_one :ratee_rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
        else
          has_many :ratee_ratings, -> { order(updated_at: :desc) }, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
        end
        if @has_one_rater
          has_one :rater_rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
        else
          has_many :rater_ratings, -> { order(updated_at: :desc) }, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
        end
      end

      def ratee_rating_average
        if @has_one_ratee
          ::Ratable::RatingAverage.new(ratings: ratee_rating, ratee: self)
        else
          ::Ratable::RatingAverage.new(ratings: ratee_rating, ratee: self)
        end
      end

      def rater_rating_average
        if @has_one_rater
          ::Ratable::RatingAverage.new(ratings: rater_rating, rater: self)
        else
          ::Ratable::RatingAverage.new(ratings: rater_ratings, rater: self)
        end
      end

      def ratees
        if @has_one_ratee
          rater_rating.ratee
        else
          rater_rating.includes(:ratee).collect { |rating| rating.ratee }
        end
      end

      def raters
        if @has_one_rater
          ratee_rating.rater
        else
          ratee_ratings.includes(:rater).collect { |rating| rating.rater }
        end
      end

      def ratee_rate(options={})
        options.reject! { |k| k == :ratee }
        if @has_one_ratee
          self.ratee_rating.create(options)
        else
          self.ratee_rating.creaste(options)
        end
      end

      def rater_rate(options)
        options.reject! { |k| k == :rater }
        if @has_one_rater
          self.rater_rating.create(options)
        else
          self.rater_ratings.create(options)
        end
      end
    end
  end
end
