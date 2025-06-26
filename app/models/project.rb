class Project < ApplicationRecord
  #-----associations-----
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :tagged_tasks, through: :tasks
  has_many :tags, through: :tagged_tasks

  before_validation :assign_default_position, on: :create
  #-----validations-----
  validates :title, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_than: 0 }


  private

  def assign_default_position
    return if position.present?
    last_position_spot = Project.where(user_id: user_id).maximum(:position) || 0
    self.position = (last_position_spot + 1)
  end
end