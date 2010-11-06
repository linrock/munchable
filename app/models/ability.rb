class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, User, :id => user.id
      can :manage, [Profile, Group, Listing], :user_id => user.id
    end
    can :create, [User, Group, Listing]
  end
end
