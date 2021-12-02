module ProductsHelper
  def show_is_active(is_active)
    return "Active" if is_active
    "Inactive"
  end
end
