module Ratable
  module Models
    module Ratee
      extend ActiveSupport::Concern

      attr_reader :options

      module ActiveRecordExtension
        def acts_as_ratee(options={has_many: true, has_one: false})
          @options = options
          include Ratee
        end
      end

      included do
        case
        when @options[:has_many]
          has_many :ratings, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
        when @options[:has_one]
          has_one :rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
        else
          throw "Invalid Ratable::Rating association between ratee and rater, ratee must either have many ratings or one rating"
        end
      end

      def raters
        ratings.collect { |rating| rating.rater }
      end

      def rate(options={})
        options.reject! { |k| k == :ratee }
        self.ratings.create(options)
      end

    end
  end
end
