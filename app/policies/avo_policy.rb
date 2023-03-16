class AvoPolicy < ActionPolicy::Base
  def view?
    user.editor? || user.admin?
  end
end