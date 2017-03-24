class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, [Book, Category]    
    
    if user
      if user.admin?
        can :read, [Address , User]
        #can :all_events, Order
        can :manage, [Book, Author, Category, Review, Picture,
                      Delivery, Coupon, Order]
        can :all_events, Order
        can :access, :rails_admin
        can :dashboard
      else
        can :read, Order, user_id: user.id
        can :manage, User, id: user.id
        can :create, Review, user_id: user.id
        can :update, Book
      end
    end
    

  end
end
