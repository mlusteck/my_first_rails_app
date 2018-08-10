module UsersHelper
  def admin_signed_in?
    signed_in? && current_user.admin?
  end
end
