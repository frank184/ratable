module Ratable
  module Models
    module Rater
      extend ActiveSupport::Concern

      attr_reader :has_one

      module ActiveRecordExtension
        def acts_as_rater(options={has_one: false})
          @has_one = options[:has_one]
          include Rater
        end
      end

      included do
        if @has_one
          has_one :rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
        else
          has_many :ratings, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
        end
      end

      def ratees
        if @has_one
          rating.ratee
        else
          ratings.collect { |rating| rating.ratee }
        end
      end

      def rate(options={})
        options.reject! { |k| k == :rater }
        if @has_one
          self.rating.create(options)
        else
          self.ratings.create(options)
        end
      end

    end
  end
end
