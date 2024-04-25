class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog_post

  scope :by_blog_post, -> (blog_post_id) { where(blog_post_id: blog_post_id) }
end
