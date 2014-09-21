module ApplicationHelper
  def navlink(text, url, link_options = {})
    content_tag :li, link_to(text, url, link_options), class: ('active' if current_page?(url))
  end

  def project_select(projects, selected = nil)
    select :invoice, :project_id, grouped_options_for_select(grouped_project_options(projects), selected), { include_blank: true }
  end

  def grouped_project_options(projects)
    projects
      .select('clients.name AS client_name, projects.name, projects.id')
      .order('clients.name, projects.name')
      .each_with_object({}) do |project, hash|

      hash[project.client_name] ||= []
      hash[project.client_name]  << [project.name, project.id]
    end
  end

  def details_block(details)
    content_tag(:ul, class: 'small-block-grid-2 medium-block-grid-4 large-block-grid-6') do
      details.map do |title, value|
        content_tag(:li, detail_block(title, value)) if value.present?
      end.join.html_safe
    end
  end

  def detail_block(title, value)
    content_tag(:ul, class: 'pricing-table') do
      content_tag(:li, title, class: 'title') +
      content_tag(:li, value, class: 'bullet-item')
    end
  end
end
