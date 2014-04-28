module ApplicationHelper
  def nav_link(link_text, link_path)
    klass_name = current_page?(link_path) ? 'active item' : 'item'

    link_to(link_text, link_path, :class => klass_name)
  end
end
