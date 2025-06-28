class Tag < ApplicationRecord
  #-----associations-----
  belongs_to :user
  has_many :tagged_tasks, dependent: :destroy
  has_many :tasks, through: :tagged_tasks

  #-----validations-----
  validates :title, presence: true

  #-----scopes-----
  scope :search_for_title, ->(searched_term) {
    where("LOWER(title) ILIKE ?", "%#{searched_term.to_s.downcase}%")
  }
end
