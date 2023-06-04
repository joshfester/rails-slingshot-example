class MembershipResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :role, as: :select, enum: ::Membership.roles
  field :user, as: :belongs_to
  field :team, as: :belongs_to
  # add fields here
end
