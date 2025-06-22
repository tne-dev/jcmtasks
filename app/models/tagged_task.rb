class TaggedTask < ApplicationRecord
  #-----model for join table between tasks and tags-----
  #-----associations-----
  belongs_to :task
  belongs_to :tag
end
