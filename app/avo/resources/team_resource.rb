class TeamResource < Avo::BaseResource
  self.title = :title
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :title, as: :text
  field :is_personal, as: :boolean
  field :owner, as: :belongs_to
  # add fields here

  action Archive
  action Restore

  filter Archived
end
