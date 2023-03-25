class Archived < Avo::Filters::SelectFilter
  self.name = "Status"

  def apply(request, query, value)
    case value
    when "archived"
      query.archived
    else
      query.not_archived
    end
  end

  def options
    {
      not_archived: "Active",
      archived: "Archived"
    }
  end

  def default
    :not_archived
  end
end
