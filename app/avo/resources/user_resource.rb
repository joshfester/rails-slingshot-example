class UserResource < Avo::BaseResource
  self.title = :email
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  self.search_query = -> do
    scope.ransack(id_eq: params[:q], email_cont: params[:q], m: "or").result(distinct: false)
  end

  field :id, as: :id
  field :email, as: :text
  field :created_at, as: :date_time, only_on: [:index, :show]
  field :updated_at, as: :date_time, only_on: [:index, :show]
  field :deleted_at, as: :date_time, only_on: [:index, :show]

  action Archive
  action Restore

  filter Archived
end
