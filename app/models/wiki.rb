class Wiki < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  scope :alphabetical, -> { order("title ASC") }
  scope :visible_to, -> (user) { (user.admin? || user.premium?) ? all : where(private: false) }

  has_many :users, through: :collaborators
  has_many :collaborators

  # before_save { self.title = title.downcase }

  def collaborator_for(user)
    collaborators.where(user_id: user.id).first
  end

  def users
    collaborators.collect(&:user)
  end

  def collabs
    users.collect(&:collaborator)
  end

end
