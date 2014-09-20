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
end
