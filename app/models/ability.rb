class Ability
  include CanCan::Ability

  def initialize(user)
    # `manage` == EVERYTHING, so we should use it with care!
    # Prefer to use `crud` that is more specific to the 7 RESTful actions
    alias_action :create, :read, :update, :destroy, to: :crud

    user ||= User.new # Guest User

    # Anyone

    # Normal
    if user.persisted?
      can :crud, Project, user_id: user.id
    end
  end
end
