class WikiPolicy < ApplicationPolicy

  class Scope

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user && user.admin?
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user && user.premium?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.users.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end

  def index?
    resolve?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def show?
    !record.private? || user && (record.user == user || user.admin? || user.premium? || record.users.include?(user))
  end

  def update?
    record.user == user || user.admin? || record.users.include?(user)
  end

  def edit?
    update?
  end

  def destroy?
    record.user == user || user.admin?
  end

end
