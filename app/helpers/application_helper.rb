module ApplicationHelper

  def full_title(page_title = "")
    if page_title == ""
      "Odinbook"
    else
      "#{page_title} | Odinbook"
    end
  end
end
