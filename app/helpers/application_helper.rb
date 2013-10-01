module ApplicationHelper
  def subnavlink(icon, text, url, options = {})
    link_to url, options.merge(class: 'flat') do
      content_tag(:span, '', class: "icon-#{icon} with-text") + text
    end
  end
end
