class Ability
  include CanCan::Ability

  def initialize user
    can :read, Tour
    return unless user.present?
    if user.admin?
      can :manage, :all
    else
      can :read, User, id: user.id
      can [:create, :read, :destroy], Booking, user_id: user.id
      can :create, Review, user_id: user.id
    end
  end
end
