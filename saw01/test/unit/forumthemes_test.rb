require File.dirname(__FILE__) + '/../test_helper'

class ForumthemesTest < Test::Unit::TestCase
  fixtures :forumthemes

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Forumthemes, forumthemes(:first)
  end
end
