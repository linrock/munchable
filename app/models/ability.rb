class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, User, :id => user.id
      can :manage, [Profile, Group, List, Listing], :user_id => user.id
    end
    can :create, User
  end
end
