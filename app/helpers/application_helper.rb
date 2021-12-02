module ApplicationHelper
  def show_validation(obj)
    if obj.errors.present?
      obj.errors.full_messages
    end
  end
end
