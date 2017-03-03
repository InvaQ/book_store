class Address < ApplicationRecord
  enum type: [:billing, :shipping]
  TYPES = types.keys
  belongs_to :addressable, polymorphic: true
end
