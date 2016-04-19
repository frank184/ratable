module Ratable
  module Models
    module Rater
      extend ActiveSupport::Concern

      attr_reader :options

      module ActiveRecordExtension
        def acts_as_rater(options={has_many: true, has_one: false})
          @options = options
          include Rater
        end
      end

      included do
        case
        when @options[:has_many]
          has_many :ratings, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
        when @options[:has_one]
          has_one :rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
        else
          throw "Invalid Ratable::Rating association between rater and ratee, rater must either have many ratings or one rating"
        end
      end

      def ratees
        ratings.collect { |rating| rating.ratee }
      end

      def rate(options={})
        options.reject! { |k| k == :rater }
        self.ratings.create(options)
      end

    end
  end
end
