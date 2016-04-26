module Ratable
  module Models
    module Ratable

      module ActiveRecordExtension
        def acts_like_ratable?
          classes = ancestors
          classes.include?(Ratee) || classes.include?(Rater)
        end

        def acts_like_ratee?
          ancestors.include?(Ratee)
        end

        def acts_like_rater?
          ancestors.include?(Rater)
        end
      end

      module ActiveRecordInclusion
        def acts_like_ratable?
          classes = self.class.ancestors
          classes.include?(Ratee) || classes.include?(Rater)
        end

        def acts_like_ratee?
          self.class.ancestors.include?(Ratee)
        end

        def acts_like_rater?
          self.class.ancestors.include?(Rater)
        end
      end

    end
  end
end
