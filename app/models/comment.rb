class Comment < ApplicationRecord
  belongs_to :gossip
  belongs_to :user
  belongs_to :comment, optional: :true
  has_many :sub_comments, class_name: 'Comment', foreign_key: 'related_comment_id', dependent: :destroy
  belongs_to :related_comment, class_name: 'Comment', optional: :true
  validates :content, presence: true
end
