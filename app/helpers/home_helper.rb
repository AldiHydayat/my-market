module HomeHelper
  def show_user
    if user_signed_in?
      current_user.name
    end
  end
end
