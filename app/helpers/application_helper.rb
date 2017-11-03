module ApplicationHelper

  def full_title(page_title = "")
    if page_title == ""
      "odinbook"
    else
      "#{page_title} | odinbook"
    end
  end
end
