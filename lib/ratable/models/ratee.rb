module Ratable
  module Models
    module Ratee
      extend ActiveSupport::Concern

      module ActiveRecordExtension
        def acts_as_ratee
          include Ratee
        end
      end

      included do
        has_many :ratings, class_name: 'Ratable::Rating', dependent: :destroy, as: :ratee
        has_many :raters, through: :ratings
      end

      def rating_average
        puts "HEY!"
      end

      def rate(value, comment)
        puts "HEY!"
      end

    end
  end
end
