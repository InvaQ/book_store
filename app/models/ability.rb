class Ability
  include CanCan::Ability

  def initialize(user)    
    user ||= User.new

    can :read, [Book, Category]
    can :show, Book
    can :read, Review

      if user.admin?
        can :manage, :all
        can :all_events, Order
        can :access, :rails_admin
        can :dashboard
      else        
        can :read, Order, user_id: user.id
        can :manage, User, id: user.id
        can :new, Review
        can :create, Review, user_id: user.id
    end
    

  end
end
