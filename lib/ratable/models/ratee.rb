module Ratable
  module Models
    module Ratee
      extend ActiveSupport::Concern

      attr_reader :options

      module ActiveRecordExtension
        def acts_as_ratee(options={has_one: false})
          @options = options
          include Ratee
        end
      end

      included do
        case @options[:has_one]
        when true
          has_one :rating, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
        else
          has_many :ratings, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
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
