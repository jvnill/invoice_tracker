module ApplicationHelper
  def navlink(text, url, active, link_options = {})
    content_tag :li, link_to(text, url, link_options), class: ('active' if active)
  end

  def subnavlink(icon, text, url, options = {})
    link_to url, options.merge(class: 'flat') do
      content_tag(:span, '', class: "icon-#{icon} with-text") + text
    end
  end
end
