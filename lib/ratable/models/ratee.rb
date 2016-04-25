module Ratable
  module Models
    module Ratee
      extend ActiveSupport::Concern
      extend Ratable::ActiveRecordExtension

      attr_reader :has_one

      module ActiveRecordExtension
        def acts_as_ratee(options={has_one: false})
          throw "To make a model the rater and the ratee use `acts_as_ratee_and_rater`" if acts_like_rater?
          @has_one = options[:has_one]
          include Ratee
        end
      end

      included do
        unless acts_like_rater?
          if @has_one
            has_one :rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
          else
            has_many :ratings, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
          end
        else
          if @has_one
            has_one :ratee_rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
          else
            has_many :ratee_ratings, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
          end
        end
      end

      def raters
        unless acts_like_rater?
          if @has_one
            rating.rater
          else
            ratings.includes(:rater).collect { |rating| rating.rater }
          end
        else
          if @has_one
            ratee_rating.rater
          else
            ratee_ratings.includes(:rater).collect { |rating| rating.rater }
          end
        end
      end

      # def rate(options={})
      #   options.reject! { |k| k == :ratee }
      #   unless acts_like_rater?
      #     if @has_one
      #       self.rating.create(options)
      #     else
      #       self.ratings.create(options)
      #     end
      #   else
      #     if @has_one
      #       self.ratee_rating.create(options)
      #     else
      #       self.ratee_ratings.create(options)
      #     end
      #   end
      # end

    end
  end
end
