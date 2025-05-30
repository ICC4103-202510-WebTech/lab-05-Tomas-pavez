class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    
    can :read, :all

   
    can :create, Message do |message|
      message.chat&.includes_user?(user)
    end
    can [:update, :destroy], Message, user_id: user.id

    
    can :create, Chat
    can [:update, :destroy], Chat do |chat|
      chat.includes_user?(user)
    end

    
    can [:update, :destroy], User, id: user.id
    can :create, User 
end