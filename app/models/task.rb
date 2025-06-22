class Task < ApplicationRecord
  #-----attachments-----
  has_one_attached :file

  #-----associations-----
  belongs_to :user
  belongs_to :project, optional: true
  has_many :tagged_tasks, dependent: :destroy
  has_many :tags, through: :tagged_tasks

  #-----validations-----
  validates :title, presence: true
  validates :is_done, inclusion: { in: [ true, false ] }
end
