class Wiki < ActiveRecord::Base
  belongs_to :user
  default_scope { order("title asc") }
  scope :visible_to, -> (user) { (user.admin? || user.premium?) ? all : where(private: false) }
end
