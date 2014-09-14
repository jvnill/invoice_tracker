module ApplicationHelper
  def navlink(text, url, link_options = {})
    content_tag :li, link_to(text, url, link_options), class: ('active' if current_page?(url))
  end
end
