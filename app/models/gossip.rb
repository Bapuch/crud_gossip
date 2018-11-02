class Gossip < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments
  has_many :likes
  validates :content, presence: true
  validates :title, presence: true
end
