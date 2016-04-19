module Ratable
  module Models
    module Rater
      extend ActiveSupport::Concern

      attr_reader :options

      module ActiveRecordExtension
        def acts_as_rater(options={has_one: false})
          @options = options
          include Rater
        end
      end

      included do
        case @options[:has_one]
        when true
          has_one :rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
        else
          has_many :ratings, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
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
