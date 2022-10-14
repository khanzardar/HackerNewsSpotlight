class Comment < ApplicationRecord
  belongs_to :story
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id
end
