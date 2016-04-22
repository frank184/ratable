module Ratable
  module Models
    module Ratable

      module ActiveRecordExtension
        def is_ratable?
          classes = ancestors
          classes.include?(Ratee) || classes.include?(Rater)
        end

        def is_ratee?
          ancestors.include?(Ratee)
        end

        def is_rater?
          ancestors.include?(Rater)
        end
      end

      module ActiveRecordInclusion
        def is_ratable?
          classes = self.class.ancestors
          classes.include?(Ratee) || classes.include?(Rater)
        end

        def is_ratee?
          self.class.ancestors.include?(Ratee)
        end

        def is_rater?
          self.class.ancestors.include?(Rater)
        end
      end

    end
  end
end