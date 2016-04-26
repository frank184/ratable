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
      end

      included do
        if @has_one
          has_one :rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
        else
          has_many :ratings, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
        end
      end

      def raters
        if @has_one
          rating.rater
        else
          ratings.includes(:rater).collect { |rating| rating.rater }
        end
      end

      def rate(options={})
        options.reject! { |k| k == :ratee }
        if @has_one
          self.rating.create(options)
        else
          self.ratings.create(options)
        end
      end

    end
  end
end
