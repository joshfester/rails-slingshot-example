class Restore < Avo::BaseAction
  self.name = "Restore"
  # self.visible = -> do
  #   true
  # end

  def handle(**args)
    models, fields, current_user, resource = args.values_at(:models, :fields, :current_user, :resource)

    models.each do |model|
      model.restore
    end
  end
end
