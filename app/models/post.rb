class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes 
  after_save :post_counter
  def post_counter
    comments.order(created_at: :desc).limit(5)
  end
  private 
  def post_counter
    author.update(post_counter: :author.posts.count)
  end
end
