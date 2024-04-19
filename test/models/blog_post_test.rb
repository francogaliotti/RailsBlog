require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  test "draft? returns true for a draft blog post" do
    assert blog_posts(:draft).draft?
  end

  test "draft? returns false for a published blog post" do
    refute blog_posts(:published).draft?
  end

  test "draft? returns false for a scheduled blog post" do
    refute blog_posts(:scheduled).draft?
  end

  test "published? returns true for a published blog post" do
    assert blog_posts(:published).published?
  end

  test "published? returns false for a scheduled blog post" do
    refute blog_posts(:scheduled).published?
  end

  test "scheduled? returns false for a published blog post" do
    refute blog_posts(:published).scheduled?
  end

  test "scheduled? returns true for a scheduled blog post" do
    assert blog_posts(:scheduled).scheduled?
  end
end
