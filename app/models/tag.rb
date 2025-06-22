class Tag < ApplicationRecord
  #-----associations-----
  belongs_to :user
  has_many :tagged_tasks, dependent: :destroy
  has_many :tasks, through: :tagged_tasks

  #-----validations-----
  validates :title, presence: true
end
