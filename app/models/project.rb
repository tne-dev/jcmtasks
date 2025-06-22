class Project < ApplicationRecord
  #-----associations-----
  belongs_to :user
  has_many :tasks, dependent: :destroy

  #-----validations-----
  validates :title, presence: true
  validates :position, presence: true
end
