module WikisHelper

  def user_is_authorized_for_wiki?(wiki)
    current_user && (current_user == wiki.user || current_user.admin?)
  end
end
