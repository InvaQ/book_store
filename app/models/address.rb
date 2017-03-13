class Address < ApplicationRecord
   
   TYPES = ['billing', 'shipping']
  belongs_to :addressable, polymorphic: true

ATTRS = [:addressable_type, :first_name, :last_name, :address, :city, :zip, :phone ].freeze
# def get_old_info(user)
#     ATTRS.each do |attribute|
#       next if !user.respond_to?(attribute) || send(attribute).present?
#       send("#{attribute}=", user.send(attribute))
#     end
#     self
#   end


end
