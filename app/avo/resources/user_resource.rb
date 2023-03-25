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
  field :deleted_at, as: :date_time

  action Archive
  action Restore
end
