module ApplicationHelper

  def full_title(page_title = "")
    if page_title == ""
      "odinbook"
    else
      "#{page_title} | odinbook"
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
