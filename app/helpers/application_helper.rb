module ApplicationHelper
  def subnavlink(icon, text, url)
    link_to url, class: 'flat' do
      content_tag(:span, '', class: "icon-#{icon} with-text") + text
    end
  end
end
