module Ratable
  module Models
    module Rater
      extend ActiveSupport::Concern

      module ActiveRecordExtension
        def acts_as_rater
          include Rater
        end
      end

      included do
        has_many :ratings, class_name: 'Ratable::Rating', dependent: :destroy, as: :rater
      end

      def ratees
        ratings.collect { |rating| rating.ratee }
      end

      def rating_average
        puts 'HEY!'
      end

      def rate
        puts 'HEY!'
      end

    end
  end
end
