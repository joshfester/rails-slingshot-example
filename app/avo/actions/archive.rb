class Archive < Avo::BaseAction
  self.name = "Archive"
  # self.visible = -> do
  #   true
  # end

  def handle(**args)
    # models, fields, current_user, resource = args.values_at(:models, :fields, :current_user, :resource)
    models = args.values_at :models

    models.each do |model|
      model.archive
    end
  end
end
