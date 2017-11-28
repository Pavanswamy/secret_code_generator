class Ability
  include CanCan::Ability

  def initialize(user)
	  if user.present? && user.admin?
	    can :manage, :all
	  end
  end
end