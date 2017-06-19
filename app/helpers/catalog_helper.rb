module CatalogHelper

  def sort_link(column, direction, title = nil)
    title ||= column.titleize
    #direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to "#{title}".html_safe, {column: column, direction: direction}
  end
end
