module ApplicationHelper

  def change_flash_class(type)
    case type
    when 'notice' then 'success'
    when 'alert' then 'warning'
    else type
    end
  end

end
