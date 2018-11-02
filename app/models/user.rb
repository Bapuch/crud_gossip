class User < ApplicationRecord
  has_many :gossips
  has_many :comments
  has_many :likes
  validates :name, presence: true, uniqueness: {scope: [:email, :password]}
  validates :email, presence: true
  validates :password, presence: true
end
