class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 250}
  validates :comments_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :likes_counter, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes
  after_save :post_counter
  def comments_recent
    comments.order(created_at: :desc).limit(5)
  end

  private

  def post_counter
    author.update(post_counter: :author.posts.count)
  end
end
