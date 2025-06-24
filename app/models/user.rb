class User < ApplicationRecord
  #-----devise-----
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #-----associations-----
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :tags, dependent: :destroy


  #---------------
  #-----logic-----

  def full_name
    "#{last_name} #{first_name}"
  end

  def welcome_msg
    "Welcome #{full_name}!"
  end
end
