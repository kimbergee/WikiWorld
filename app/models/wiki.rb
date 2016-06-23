class Wiki < ActiveRecord::Base
  belongs_to :user
  scope :alphabetical, -> { order("title ASC") }
  scope :visible_to, -> (user) { (user.admin? || user.premium?) ? all : where(private: false) }

  before_save { self.title = title.downcase }
end
