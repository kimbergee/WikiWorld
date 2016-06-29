module WikisHelper

  def user_is_authorized_for_wiki?(wiki)
    current_user && (current_user == wiki.user || current_user.admin? || wiki.users.include?(current_user))
  end

  def user_is_authorized_for_wiki_delete?(wiki)
    current_user && (current_user == wiki.user || current_user.admin?)
  end

  def authorized_to_add_collabs?(wiki)
    wiki.private? && (wiki.user == current_user || current_user.admin?)
  end

end
