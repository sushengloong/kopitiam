module ApplicationHelper
  def is_current_user? user
    user_id = user.is_a?(User) ? user.id : user
    user_signed_in? && current_user.id == user_id
  end
end
