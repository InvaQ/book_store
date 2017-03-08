class Review < ApplicationRecord
  include AASM

  belongs_to :book
  belongs_to :user

  aasm column: :state, whiny_transitions: false do
    state :unchecked, inital: true
    state :approved
    state :rejected

    event :approve do
      transitions from: :unchecked, to: :approved
    end

    event :reject do
      transitions from: :unchecked, to: :rejected
    end

  end


  def self.get_states
    aasm.states.map(&:name)
  end

  def published_at
    created_at.strftime('%d/%m/%y')
  end

  def user_name
    user.email
  end

end
