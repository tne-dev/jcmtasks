class Task < ApplicationRecord
  #-----attachments-----
  has_one_attached :file

  #-----associations-----
  belongs_to :user
  belongs_to :project, optional: true
  delegate :title, to: :project, prefix: true, allow_nil: true

  has_many :tagged_tasks, dependent: :destroy
  has_many :tags, through: :tagged_tasks

  #-----validations-----
  validates :title, presence: true
  validates :is_done, inclusion: { in: [ true, false ] }

  #-----scopes-----
  scope :per_project, ->(project) { where(project: project) }
  scope :search_for_title, ->(searched_term) {
    where("LOWER(title) ILIKE ?", "%#{searched_term.to_s.downcase}%")
  }

  def status?
    is_done ? "Complete" : "Incomplete"
  end
end
