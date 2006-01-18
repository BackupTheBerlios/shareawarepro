class Forumfolder < ActiveRecord::Base
has_many :forumthemes

  # Example:
  #   @folder = Forumfolder.getfolder(2)
  #
  def self.getFolder(id)
    find_first(["id = ?", id])
  end

end
