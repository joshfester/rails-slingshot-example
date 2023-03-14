module RansackSearchable
  def ransack_search(model)
    @pagy, @resources = pagy model.ransack(params[:q])
  end
end