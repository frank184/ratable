class Post < ActiveRecord::Base
  acts_as_ratee has_one: true
end
