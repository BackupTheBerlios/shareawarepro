require File.dirname(__FILE__) + '/../test_helper'

class ForumfoldersTest < Test::Unit::TestCase
  fixtures :forumfolders

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Forumfolders, forumfolders(:first)
  end
end
