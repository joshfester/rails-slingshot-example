class InvitationResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :email, as: :text
  field :from_membership, as: :belongs_to
  field :role, as: :text
  field :team, as: :belongs_to
  # add fields here
end
