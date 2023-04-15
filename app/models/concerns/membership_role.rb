module MembershipRole
  extend ActiveSupport::Concern

  included do
    enum role: {
      member: "member",
      admin: "admin"
    }
  end
end
