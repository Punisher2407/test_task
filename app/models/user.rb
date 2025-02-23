class User < ApplicationRecord
  has_many :user_interests, dependent: :destroy
  has_many :interests, through: :user_interests
  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills

  validates :surname, :name, :patronymic, :email, :nationality, :country, :gender, presence: true
  validates :email, uniqueness: true
  validates :age, numericality: { greater_than: 0, less_than_or_equal_to: 90 }
  validates :gender, inclusion: { in: %w[male female] }

  before_save :update_full_name

  private 

  def update_full_name
    self.full_name = [surname, name, patronymic].compact_blank.join(" ")
  end
end
