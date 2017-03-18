class Address < ApplicationRecord
   
   TYPES = ['billing', 'shipping']
  belongs_to :addressable, polymorphic: true

ATTRS = [:addressable_type, :first_name, :last_name, :address, :city, :zip, :phone ].freeze



end
