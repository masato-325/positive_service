module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when 'notice'
      'success' # Green
    when 'alert', 'error'
      'danger' # Red
    else
      flash_type.to_s
    end
  end
end
