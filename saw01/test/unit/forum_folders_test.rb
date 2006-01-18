require File.dirname(__FILE__) + '/../test_helper'

class ForumFoldersTest < Test::Unit::TestCase
  fixtures :forum_folders

  # Replace this with your real tests.
  def test_truth
    assert_kind_of ForumFolders, forum_folders(:first)
  end
end
